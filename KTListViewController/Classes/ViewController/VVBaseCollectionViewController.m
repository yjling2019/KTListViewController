//
//  VVBaseCollectionViewController.m
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "VVBaseCollectionViewController.h"
#import "VVBaseViewModel.h"
#import "VVDataHelper.h"
#import <KVOController/KVOController.h>

@interface VVBaseCollectionViewController ()

@end

@implementation VVBaseCollectionViewController

@dynamic collectionViewModel;
@synthesize collectionView = _collectionView;

#pragma mark - life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self vc_registerCells];
    [self vc_registerReuseViews];
    
    [self vc_setUpUI];
    [self vc_setUpConstraints];
    [self vc_bindUIActions];
	[self vc_addObservers];
	[self vc_loadInitialData];
	[self vc_loadInitialDataFromServer];
}

- (void)vc_setUpUI
{
    
}

- (void)vc_setUpConstraints
{
    
}

- (void)vc_bindUIActions
{
    
}

- (void)vc_addObservers
{
	[self.KVOController observe:self.collectionViewModel keyPath:@"datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
		[self vc_registerCells];
		[self vc_registerReuseViews];
	}];
}

- (void)vc_loadInitialData
{
	
}

- (void)vc_loadInitialDataFromServer
{
	
}

- (void)vc_registerCells
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <VVSectionModelProtocol> section in self.collectionViewModel.datas) {
		for (id <VVReuseViewModelProtocol> model in section.datas) {
			if ([model respondsToSelector:@selector(reuseViewClassName)] && model.reuseViewClassName) {
				Class cls = NSClassFromString(model.reuseViewClassName);
				if (cls) {
					[set addObject:cls];
				}
			}
		}
	}
	
	for (Class cellClass in [set allObjects]) {
		if ([cellClass conformsToProtocol:@protocol(VVCollectionCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass identifier]];
		}
	}
	[self.collectionView registerClass:VVBaseCollectionCell.class
			forCellWithReuseIdentifier:[VVBaseCollectionCell identifier]];
}

- (void)vc_registerReuseViews
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <VVSectionModelProtocol> section in self.collectionViewModel.datas) {
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
		if ([reuseViewClass conformsToProtocol:@protocol(VVCollectionReuseViewProtocol)]
			&& [reuseViewClass respondsToSelector:@selector(kind)]
			&& [reuseViewClass respondsToSelector:@selector(identifier)]) {
			[self.collectionView registerClass:reuseViewClass forSupplementaryViewOfKind:[reuseViewClass kind] withReuseIdentifier:[reuseViewClass identifier]];
		}
	}
	
	[self.collectionView registerClass:VVBaseCollectionReuseView.class
			forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
				   withReuseIdentifier:[VVBaseCollectionReuseView identifier]];
	
	[self.collectionView registerClass:VVBaseCollectionReuseView.class
			forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
				   withReuseIdentifier:[VVBaseCollectionReuseView identifier]];
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
        NSString *identifierString = [NSClassFromString(className) identifier];
        if (vv_isEmptyStr(identifierString)) {
            NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
            identifierString = [VVBaseCollectionReuseView identifier];
        }
		NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");
        
		VVBaseCollectionReuseView *reuseHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifierString forIndexPath:indexPath];
        id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:indexPath.section];
        [reuseHeaderView updateWithModel:model];
        return reuseHeaderView;
	} else {
		NSString *className = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:indexPath.section];
		NSString *identifierString = [NSClassFromString(className) identifier];
		if (vv_isEmptyStr(identifierString)) {
			NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
			identifierString = [VVBaseCollectionReuseView identifier];
		}
		NSAssert((kind == [NSClassFromString(className) kind]), @"kind不一致");
		
		VVBaseCollectionReuseView *reuseFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifierString forIndexPath:indexPath];
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
        identifierString = [VVBaseCollectionCell identifier];
    }
    VVBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    cell.vv_model = model;
    [cell updateWithModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    CGSize itemSize = [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
						layout:(UICollectionViewLayout*)collectionViewLayout
		insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets = [self.collectionViewModel sectionInsetsWithSection:section];
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinLineSpacing = [self.collectionViewModel itemMinLineSpacingWithSection:section];
    return itemMinLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinInterSpacing = [self.collectionViewModel itemMinInterSpacingWithSection:section];
    return itemMinInterSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewHeaderViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:section];
    CGSize headerViewSize = [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize = [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
    return footerViewSize;
}

- (void)collectionView:(UICollectionView *)collectionView
willDisplaySupplementaryView:(UICollectionReusableView *)view
		forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView <VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
	   willDisplayCell:(UICollectionViewCell *)cell
	forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView <VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
didEndDisplayingSupplementaryView:(UICollectionReusableView *)view
	  forElementOfKind:(NSString *)elementKind
		   atIndexPath:(NSIndexPath *)indexPath
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView <VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
	forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView <VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView removeReuseViewModelObservers];
    }
}

#pragma mark - VVCollectionCustomLayoutDelegate
/// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView
			   customLayout:(UICollectionViewLayout *)collectionViewLayout
	  columnNumberAtSection:(NSInteger )section
{
    NSInteger columnNumber = [self.collectionViewModel sectionColumnNumberWithSection:section];
    return columnNumber;
}

/// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView
			customLayout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
    id model = [self.collectionViewModel modelWithIndexPath:indexPath];
    CGSize itemSize = [NSClassFromString(cellClassName) itemSizeWithModel:model];
    return itemSize;
}

/// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
				  customLayout:(UICollectionViewLayout*)collectionViewLayout
		insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInsets = [self.collectionViewModel sectionInsetsWithSection:section];
    return sectionInsets;
}

/// 每个区内部的垂直距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
			 customLayout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinLineSpacing = [self.collectionViewModel itemMinLineSpacingWithSection:section];
    return itemMinLineSpacing;
}

/// 每个区内部的水平距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
			 customLayout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat itemMinInterSpacing = [self.collectionViewModel itemMinInterSpacingWithSection:section];
    return itemMinInterSpacing;
}

/// header size
- (CGSize)collectionView:(UICollectionView *)collectionView
			customLayout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewHeaderViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewHeaderViewWithSection:section];
    CGSize headerViewSize = [NSClassFromString(reuseViewClassName) headerViewSizeWithModel:model];
    return headerViewSize;
}

/// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView
			customLayout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.collectionViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.collectionViewModel modelOfReuseViewFooterViewWithSection:section];
    CGSize footerViewSize = [NSClassFromString(reuseViewClassName) footerViewSizeWithModel:model];
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

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
#warning TODO 1210
        UICollectionViewLayout *layout = [self vc_collectionViewLayout];
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

- (UICollectionViewLayout *)vc_collectionViewLayout
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	return layout;
}

#pragma mark - dealloc
- (void)dealloc
{
	[self vc_removeObservers];
}

@end
