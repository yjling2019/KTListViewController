//
//  KTBaseCollectionContainerView.m
//  KOTU
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionContainerView.h"
#import "KTBaseViewModel.h"
#import <KVOController/KVOController.h>
#import "UIScrollView+Preload.h"
#import <MJRefresh/MJRefresh.h>
#import <KTFoundation/NSArray+KTHelp.h>
#import <KTFoundation/KTScope.h>

static id <KTPromptViewDataSource> _globlePromptViewDataSource;

@implementation KTBaseCollectionContainerView

@dynamic collectionViewModel;
@synthesize collectionView = _collectionView;
KTSynthesizePromptContainerProtocol

#pragma mark - init override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		if ([self kt_autoSetup]) {
			[self kt_setUp];
		}
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

#pragma mark - KTViewContainerProtocol
- (BOOL)kt_autoSetup
{
	return YES;
}

- (void)kt_setUp
{
	[self kt_setUpUI];
	[self kt_setUpConstraints];
	[self kt_bindUIActions];
	[self kt_addObservers];
	[self kt_loadInitialData];
	
	[self kt_setUpRefresher];
}

- (void)kt_setUpUI
{
}

- (void)kt_setUpConstraints
{
}

- (void)kt_bindUIActions
{
}

- (void)kt_loadInitialData
{
	if (!_promptViewDataSource) {
		_promptViewDataSource = _globlePromptViewDataSource;
	}
}

- (void)kt_loadInitialDataFromServer
{
}

- (void)kt_refreshUI
{
}

- (void)kt_addObservers
{
	@weakify(self);
	[self.KVOControllerNonRetaining observe:self keyPath:@"collectionViewModel.datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
		@strongify(self);
		[self kt_registerCells];
		[self kt_registerReuseViews];
	}];
}

- (void)kt_removeObservers
{
}

#pragma mark - KTPromptContainerProtocol
+ (void)kt_setupGlobalPromptViewDataSource:(id<KTPromptViewDataSource>)dataSource
{
	_globlePromptViewDataSource = dataSource;
}

- (void)setPromptViewDataSource:(id<KTPromptViewDataSource>)promptViewDataSource
{
	[self kt_promptDismiss];
	
	_promptLoadingView = nil;
	_promptExceptionView = nil;
	_promptEmptyDataView = nil;
	
	_promptViewDataSource = promptViewDataSource;
}

#pragma mark - KTPromptProtocol
- (void)kt_promptShowLoadingView
{
	[_promptLoadingView promptDismiss];
	[self.promptLoadingView showPromptViewInView:self.collectionView];
}

- (void)kt_promptShowEmptyDataView
{
	[_promptEmptyDataView promptDismiss];
	[self.promptEmptyDataView showPromptViewInView:self.collectionView];
}

- (void)kt_promptShowExceptionViewWithRefreshHandle:(void(^)(void))refreshBlock
{
	[_promptExceptionView promptDismiss];

	if ([self.promptExceptionView respondsToSelector:@selector(promptActionBlock)]) {
		self.promptExceptionView.promptActionBlock = refreshBlock;
	}
	
	[self.promptExceptionView showPromptViewInView:self.collectionView];
}

- (void)kt_promptDismiss
{
	[_promptLoadingView promptDismiss];
	[_promptEmptyDataView promptDismiss];
	[_promptExceptionView promptDismiss];
}

- (UIView *)promptLoadingView
{
	if (!_promptLoadingView) {
		_promptLoadingView = [self.promptViewDataSource kt_promptLoadingView];
	}
	return _promptLoadingView;
}

- (UIView *)promptEmptyDataView
{
	if (!_promptEmptyDataView) {
		_promptEmptyDataView = [self.promptViewDataSource kt_promptEmptyDataView];
	}
	return _promptEmptyDataView;
}

- (UIView *)promptExceptionView
{
	if (!_promptExceptionView) {
		_promptExceptionView = [self.promptViewDataSource kt_promptExceptionView];
	}
	return _promptExceptionView;
}

#pragma mark - KTListViewControllerProtocol
- (void)kt_registerCells
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

- (void)kt_registerReuseViews
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

- (void)kt_setUpRefresher
{
	if ([self.collectionViewModel respondsToSelector:@selector(refreshHeaderClass)] &&
		self.collectionViewModel.refreshHeaderClass &&
		NSClassFromString(self.collectionViewModel.refreshHeaderClass) &&
		[NSClassFromString(self.collectionViewModel.refreshHeaderClass) respondsToSelector:@selector(headerWithRefreshingBlock:)] &&
		!self.collectionView.mj_header) {
		
		__weak typeof(self) weakSelf = self;
		MJRefreshHeader *header = [NSClassFromString(self.collectionViewModel.refreshHeaderClass) headerWithRefreshingBlock:^{
			[weakSelf kt_pullRefresh];
		}];
		self.collectionView.mj_header = header;
	}
	
	if ([self.collectionViewModel respondsToSelector:@selector(refreshFooterClass)] &&
		self.collectionViewModel.refreshFooterClass &&
		NSClassFromString(self.collectionViewModel.refreshFooterClass) &&
		[NSClassFromString(self.collectionViewModel.refreshFooterClass) respondsToSelector:@selector(footerWithRefreshingBlock:)] &&
		!self.collectionView.mj_footer) {
		
		__weak typeof(self) weakSelf = self;
		MJRefreshFooter *footer = [NSClassFromString(self.collectionViewModel.refreshFooterClass) footerWithRefreshingBlock:^{
			[weakSelf kt_loadMore];
		}];
		self.collectionView.mj_footer = footer;
	}
}

- (void)kt_pullRefresh
{
}

- (void)kt_loadMore
{
}

- (void)kt_preloadListView:(UICollectionView *)listView atIndexPath:(NSIndexPath *)indexPath
{
	if (![self.collectionViewModel respondsToSelector:@selector(preloadMinCount)]) {
		return;
	}
	
	id <KTSectionModelProtocol> section = [self.collectionViewModel.datas kt_objectAtIndex:indexPath.section];
	if (![section respondsToSelector:@selector(datas)]) {
		return;
	}
	
	[listView preloadWithCurrentItemIndex:indexPath.row totalDataCount:section.datas.count minCount:self.collectionViewModel.preloadMinCount];
}

- (void)kt_listView:(__kindof UIView *)listView didSelectItem:(id<KTReuseViewModelProtocol>)item
{
}

#pragma mark - KTCollectionViewContainerProtocol
- (UICollectionViewLayout *)collectionViewLayout
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	return layout;
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
		if (!identifierString) {
			NSAssert(NO, @"KOTU error: empty reuse identifier");
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
		if (!identifierString) {
			NSAssert(NO, @"KOTU error: empty reuse identifier");
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
	[self kt_preloadListView:collectionView atIndexPath:indexPath];

	NSString *className = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
	NSString *identifierString = [NSClassFromString(className) identifier];
	if (!identifierString) {
		NSAssert(NO, @"KOTU error: empty reuse identifier");
		identifierString = [KTBaseCollectionCell identifier];
	}
	KTBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
	id model = [self.collectionViewModel modelWithIndexPath:indexPath];
	[cell updateWithModel:model];
	return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	id model = [self.collectionViewModel modelWithIndexPath:indexPath];
	[self kt_listView:collectionView didSelectItem:model];
}

- (void)collectionView:(UICollectionView *)collectionView
willDisplaySupplementaryView:(UICollectionReusableView *)view
		forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
	if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
		&& [view respondsToSelector:@selector(kt_addReuseViewModelObservers)]) {
		UIView <KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
		[reuseView kt_addReuseViewModelObservers];
	}
}

- (void)collectionView:(UICollectionView *)collectionView
	   willDisplayCell:(UICollectionViewCell *)cell
	forItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
		&& [cell respondsToSelector:@selector(kt_addReuseViewModelObservers)]) {
		UIView <KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
		[reuseView kt_addReuseViewModelObservers];
	}
}

- (void)collectionView:(UICollectionView *)collectionView
didEndDisplayingSupplementaryView:(UICollectionReusableView *)view
	  forElementOfKind:(NSString *)elementKind
		   atIndexPath:(NSIndexPath *)indexPath
{
	if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
		&& [view respondsToSelector:@selector(kt_removeReuseViewModelObservers)]) {
		UIView <KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
		[reuseView kt_removeReuseViewModelObservers];
	}
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
	forItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
		&& [cell respondsToSelector:@selector(kt_removeReuseViewModelObservers)]) {
		UIView <KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
		[reuseView kt_removeReuseViewModelObservers];
	}
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

#pragma mark - KTWaterfallFlowLayoutDelegate
/// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView
					 layout:(KTWaterfallFlowLayout *)collectionViewLayout
	  columnNumberAtSection:(NSInteger )section
{
	NSInteger columnNumber = [self.collectionViewModel sectionColumnNumberWithSection:section];
	return columnNumber;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout *)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
				itemWidth:(CGFloat)itemWidth
{
#warning TODO 不严谨
	NSString *cellClassName = [self.collectionViewModel reuseViewClassNameWithIndexPath:indexPath];
	id model = [self.collectionViewModel modelWithIndexPath:indexPath];
	CGSize itemSize = [NSClassFromString(cellClassName) itemSizeWithModel:model];
	return itemSize.height;
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
		_collectionView.showsVerticalScrollIndicator = NO;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark - dealloc override
- (void)dealloc
{
    [self kt_removeObservers];
}

@end
