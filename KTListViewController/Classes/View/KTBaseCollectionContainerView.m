//
//  KTBaseCollectionContainerView.m
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionContainerView.h"
#import "KTBaseViewModel.h"
#import "VVDataHelper.h"
#import <KVOController/KVOController.h>

@implementation KTBaseCollectionContainerView

@dynamic collectionViewModel;
@synthesize collectionView = _collectionView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setUpUI];
		[self setUpConstraints];
		[self bindUIActions];
		[self loadInitialData];
		[self view_addObservers];
    }
    return self;
}

#pragma mark - public
- (void)reloadData
{
	[self.collectionView reloadData];
}

- (nullable UICollectionViewCell *)cellOfReuseViewModel:(id<KTReuseViewModelProtocol>)vm
{
	if (!vm) {
		return nil;
	}
	
	NSIndexPath *indexPath;
	
	for (id <KTSectionModelProtocol> sectionVM in self.collectionViewModel.datas) {
		NSInteger item = [sectionVM.datas indexOfObject:vm];
		if (item == NSNotFound) {
			continue;
		}
		
		NSInteger section = [self.collectionViewModel.datas indexOfObject:sectionVM];
		if (section == NSNotFound) {
			NSAssert(NO, @"KTBaseCollectionViewVM: section not found, maybe self.datas changed");
			continue;
		}
			
		indexPath = [NSIndexPath indexPathForItem:item inSection:section];
		break;
	}
	
	if (!indexPath) {
		return nil;
	}
	
	UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
	return cell;
}

#pragma mark - KTViewProtocol
- (void)setUpUI
{
	
}

- (void)setUpConstraints
{
	
}

- (void)bindUIActions
{
	
}

- (void)loadInitialData
{
	
}

- (void)view_addObservers
{
	[self.KVOController observe:self keyPath:@"collectionViewModel.datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
		[self registerCells];
		[self registerReuseViews];
	}];
}

- (void)view_removeObservers
{
	
}

- (void)updateWithModel:(id<KTReuseViewModelProtocol>)model
{
    
}

- (void)pullRefresh
{
	
}

- (void)loadMore
{
	
}

#pragma mark - KTListViewProtocol
- (void)registerCells
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <KTSectionModelProtocol> section in self.collectionViewModel.datas) {
		for (id <KTReuseViewModelProtocol> model in section.datas) {
			if ([model respondsToSelector:@selector(reuseViewClassName)] && model.reuseViewClassName) {
				Class cls = NSClassFromString(model.reuseViewClassName);
				if (cls) {
					[set addObject:cls];
				}
			}
		}
	}
	
	for (Class cellClass in [set allObjects]) {
		if ([cellClass conformsToProtocol:@protocol(KTCollectionCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass identifier]];
		}
	}
	
    [self.collectionView registerClass:KTBaseCollectionCell.class
			forCellWithReuseIdentifier:[KTBaseCollectionCell identifier]];
}

- (void)registerReuseViews
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <KTSectionModelProtocol> section in self.collectionViewModel.datas) {
		if ([section.headerModel respondsToSelector:@selector(reuseViewClassName)] &&
			section.headerModel.reuseViewClassName) {
			Class cls = NSClassFromString(section.headerModel.reuseViewClassName);
			if (cls) {
				[set addObject:cls];
			}
		}
		
		if ([section.footerModel respondsToSelector:@selector(reuseViewClassName)] &&
			section.footerModel.reuseViewClassName) {
			Class cls = NSClassFromString(section.footerModel.reuseViewClassName);
			if (cls) {
				[set addObject:cls];
			}
		}
	}
	
	for (Class reuseViewClass in [set allObjects]) {
		if ([reuseViewClass conformsToProtocol:@protocol(KTCollectionReuseViewProtocol)]
			&& [reuseViewClass respondsToSelector:@selector(kind)]
			&& [reuseViewClass respondsToSelector:@selector(identifier)]) {
			[self.collectionView registerClass:reuseViewClass forSupplementaryViewOfKind:[reuseViewClass kind] withReuseIdentifier:[reuseViewClass identifier]];
		}
	}
    
    [self.collectionView registerClass:KTBaseCollectionReuseView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[KTBaseCollectionReuseView identifier]];
    
    [self.collectionView registerClass:KTBaseCollectionReuseView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:[KTBaseCollectionReuseView identifier]];
}

- (UICollectionViewLayout *)collectionViewLayout
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	return layout;
}

#pragma mark - VVCollectionViewContainerProtocol
- (void)collectionView:(UIView *)collectionView didSelectItem:(id <KTReuseViewModelProtocol>)item
{
	
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
		NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");

		NSString *identifierString = [NSClassFromString(className) identifier];
		if (vv_isEmptyStr(identifierString)) {
			NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
			identifierString = [KTBaseCollectionReuseView identifier];
		}
		
		KTBaseCollectionReuseView *reuseHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifierString forIndexPath:indexPath];
		id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:indexPath.section];
		[reuseHeaderView updateWithModel:model];
		return reuseHeaderView;
	} else {
		NSString *className = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:indexPath.section];
		NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");

		NSString *identifierString = [NSClassFromString(className) identifier];
		if (vv_isEmptyStr(identifierString)) {
			NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
			identifierString = [KTBaseCollectionReuseView identifier];
		}
		
		KTBaseCollectionReuseView *reuseFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifierString forIndexPath:indexPath];
		id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:indexPath.section];
		[reuseFooterView updateWithModel:model];
		return reuseFooterView;
	}
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self respondsToSelector:@selector(preloadWithIndexPath:)]) {
		[self preloadWithIndexPath:indexPath];
	}
	NSString *className = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
	NSString *identifierString = [NSClassFromString(className) identifier];
	if (vv_isEmptyStr(identifierString)) {
		NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
		identifierString = [KTBaseCollectionCell identifier];
	}
	KTBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
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
    CGSize itemSize = [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets = [self.collectionViewModel sectionInsetsWithSection:section];
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinLineSpacing = [self.collectionViewModel itemMinLineSpacingWithSection:section];
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
    CGSize headerViewSize = [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize = [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
    return footerViewSize;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
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
    CGSize itemSize = [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

/// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets = [self.collectionViewModel sectionInsetsWithSection:section];
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
    CGSize headerViewSize = [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

/// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize = [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
    return footerViewSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	id model = [self.collectionViewModel modelWithIndexPath:indexPath];
	[self collectionView:collectionView didSelectItem:model];
}

#pragma mark - getter
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

#pragma mark - dealloc
- (void)dealloc
{
    [self view_removeObservers];
}

@end
