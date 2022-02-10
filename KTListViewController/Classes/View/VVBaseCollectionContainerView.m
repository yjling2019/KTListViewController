//
//  VVBaseCollectionContainerView.m
//  MVVMDemo
//
//  Created by JackLee on 2019/8/17.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import "VVBaseCollectionContainerView.h"
#import "VVBaseViewModel.h"
#import "VVDataHelper.h"

@implementation VVBaseCollectionContainerView
@dynamic collectionViewModel;
@synthesize collectionView = _collectionView;

static NSString * const defaultReuseIdentifier = @"VVDefaultCellID";
static NSString * const defaultViewReuseIdentifier = @"VVReuseViewID";

- (NSArray <Class>*)cellClasses
{
    if (self.collectionViewModel.config.cellClassName && NSClassFromString(self.collectionViewModel.config.cellClassName)) {
        return @[NSClassFromString(self.collectionViewModel.config.cellClassName)];
    }
    return @[];
}

- (NSArray <Class>*)resuseViewClasses
{
    NSMutableArray *array = [NSMutableArray new];
    if (self.collectionViewModel.config.headerClassName && NSClassFromString(self.collectionViewModel.config.headerClassName)) {
        [array addObject:NSClassFromString(self.collectionViewModel.config.headerClassName)];
    }
    if (self.collectionViewModel.config.footerClassName && NSClassFromString(self.collectionViewModel.config.footerClassName)) {
        [array addObject:NSClassFromString(self.collectionViewModel.config.footerClassName)];
    }
    return [array copy];
}

- (UICollectionViewLayout *)collectionViewLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return layout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self vv_autoInit]) {
            
            [self registerCells];
            [self registerReuseViews];
            
            [self setUpUI];
            [self setUpConstraints];
            [self bindUIActions];
            [self view_addObservers];
        }
    }
    return self;
}

- (BOOL)vv_autoInit
{
    return YES;
}

- (void)setUpUI
{
    
}

- (void)setUpConstraints
{
    
}

- (void)bindUIActions
{
    
}

- (void)view_addObservers
{
    
}

- (void)view_removeObservers
{
    
}

- (void)updateWithModel:(id)model
{
    
}

- (void)registerCells
{
    for (Class cellClass in [self cellClasses]) {
        if ([cellClass conformsToProtocol:@protocol(VVCollectionCellProtocol)]
            && [cellClass respondsToSelector:@selector(identifier)]) {
            [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass identifier]];
        }
    }
    [self.collectionView registerClass:VVBaseCollectionCell.class forCellWithReuseIdentifier:defaultReuseIdentifier];
}

- (void)registerReuseViews
{
    for (Class reuseViewClass in [self resuseViewClasses]) {
        if ([reuseViewClass conformsToProtocol:@protocol(VVCollectionReuseViewProtocol)]
            && [reuseViewClass respondsToSelector:@selector(kind)]
            && [reuseViewClass respondsToSelector:@selector(identifier)]) {
            [self.collectionView registerClass:reuseViewClass forSupplementaryViewOfKind:[reuseViewClass kind] withReuseIdentifier:[reuseViewClass identifier]];
        }
    }
    
    [self.collectionView registerClass:VVBaseCollectionReuseView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:defaultViewReuseIdentifier];
    
    [self.collectionView registerClass:VVBaseCollectionReuseView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:defaultViewReuseIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.collectionViewModel sectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionViewModel itemCountWithSection:section];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        NSString *className = [self.collectionViewModel reuseViewHeaderViewClassNameWithSection:indexPath.section];
        NSString *identifierString = nil;
        if (!className
            && ![self.collectionViewModel modelOfReuseViewHeaderViewWithSection:indexPath.section]) {
            className = NSStringFromClass([VVBaseCollectionReuseView class]);
            identifierString = defaultViewReuseIdentifier;
        } else {
            identifierString = [NSClassFromString(className) identifier];
        }
        if (vv_isEmptyStr(identifierString)) {
    #if DEBUG
            NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
    #endif
            identifierString = defaultViewReuseIdentifier;
        }
        
#if DEBUG
        NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");
#endif
        VVBaseCollectionReuseView *reuseHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:[NSClassFromString(className) kind] withReuseIdentifier:identifierString forIndexPath:indexPath];
        id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:indexPath.section];
        [reuseHeaderView updateWithModel:model];
        return reuseHeaderView;
    }
    NSString *className = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:indexPath.section];
    NSString *identifierString = nil;
    if (!className
        && ![self.collectionViewModel modelOfReuseViewFooterViewWithSection:indexPath.section]) {
        className = NSStringFromClass([VVBaseCollectionReuseView class]);
        identifierString = defaultViewReuseIdentifier;
    } else {
        identifierString = [NSClassFromString(className) identifier];
    }
    if (vv_isEmptyStr(identifierString)) {
#if DEBUG
        NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
#endif
        identifierString = defaultViewReuseIdentifier;
    }
#if DEBUG
    NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");
#endif
    VVBaseCollectionReuseView *reuseFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:[NSClassFromString(className) kind] withReuseIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:indexPath.section];
    [reuseFooterView updateWithModel:model];
    return reuseFooterView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self respondsToSelector:@selector(preloadWithIndexPath:)]) {
        [self preloadWithIndexPath:indexPath];
    }
    NSString *className = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
    NSString *identifierString = [NSClassFromString(className) identifier];
    if (vv_isEmptyStr(identifierString)) {
#if DEBUG
        NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
#endif
        identifierString = defaultReuseIdentifier;
    }
    VVBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    cell.vv_model = model;
    [cell updateWithModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    CGSize itemSize= [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets= [self.collectionViewModel sectionInsetsWithSection:section];
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinLineSpacing= [self.collectionViewModel itemMinLineSpacingWithSection:section];
    return itemMinLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinInterSpacing = [self.collectionViewModel itemMinInterSpacingWithSection:section];
    return itemMinInterSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewHeaderViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:section];
    CGSize headerViewSize= [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize= [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
    return footerViewSize;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView removeReuseViewModelObservers];
    }
}

#pragma mark - VVCollectionCustomLayoutDelegate
/// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section
{
    NSInteger columnNumber= [self.collectionViewModel sectionColumnNumberWithSection:section];
    return columnNumber;
}

/// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    CGSize itemSize= [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

/// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets= [self.collectionViewModel sectionInsetsWithSection:section];
    return sectionInsets;
}

/// 每个区内部的垂直距离
- (CGFloat)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinLineSpacing= [self.collectionViewModel itemMinLineSpacingWithSection:section];
    return itemMinLineSpacing;
}

/// 每个区内部的水平距离
- (CGFloat)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinInterSpacing = [self.collectionViewModel itemMinInterSpacingWithSection:section];
    return itemMinInterSpacing;
}

/// header size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewHeaderViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:section];
    CGSize headerViewSize= [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

/// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize= [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
    return footerViewSize;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
//    if ([model isKindOfClass:[VVBaseViewModel class]]) {
//        VVBaseViewModel *viewModel = (VVBaseViewModel *)model;
//        if (viewModel.vv_link) {
//
//        } else if (viewModel.vv_eventName) {
//
//        }
//    }
//}

#pragma mark - - getter - -
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLayout *layout = [self collectionViewLayout];
#warning TODO 1210
//        if ([layout conformsToProtocol:@protocol(VVCollectionViewCustomLayoutProtocol)]) {
//            UICollectionViewLayout<VVCollectionViewCustomLayoutProtocol> *customLayout = (UICollectionViewLayout<VVCollectionViewCustomLayoutProtocol> *)layout;
//            if ([customLayout respondsToSelector:@selector(vv_layoutDelegate)]
//                && [customLayout respondsToSelector:NSSelectorFromString(@"setVv_layoutDelegate:")]) {
//                customLayout.vv_layoutDelegate = self;
//            }
//        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end
