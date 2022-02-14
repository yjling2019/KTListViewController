//
//  KTBaseTableContainerView.m
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseTableContainerView.h"
#import "VVDataHelper.h"
#import <KVOController/KVOController.h>

@implementation KTBaseTableContainerView

@dynamic tableViewModel;
@synthesize tableView = _tableView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self registerCells];
		[self registerReuseViews];
		
		[self setUpUI];
		[self setUpConstraints];
		[self bindUIActions];
		[self view_addObservers];
    }
    return self;
}

#pragma mark - public
- (void)reloadData
{
	[self.tableView reloadData];
}

- (nullable UITableViewCell *)cellOfReuseViewModel:(id<KTReuseViewModelProtocol>)vm
{
	if (!vm) {
		return nil;
	}
	
	NSIndexPath *indexPath;
	
	for (id <KTSectionModelProtocol> sectionVM in self.tableViewModel.datas) {
		NSInteger item = [sectionVM.datas indexOfObject:vm];
		if (item == NSNotFound) {
			continue;
		}
		
		NSInteger section = [self.tableViewModel.datas indexOfObject:sectionVM];
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
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
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
	[self.KVOController observe:self keyPath:@"tableViewModel.datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
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

#pragma mark - VVTableViewContainerProtocol
- (void)tableView:(UITableView *)tableView didSelectItem:(id <KTReuseViewModelProtocol>)item
{
	
}

#pragma mark - KTListViewProtocol
- (void)registerCells
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <KTSectionModelProtocol> section in self.tableViewModel.datas) {
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
		if ([cellClass conformsToProtocol:@protocol(KTTableCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass identifier]];
		}
	}
	
	[self.tableView registerClass:KTBaseTableViewCell.class
		   forCellReuseIdentifier:[KTBaseTableViewCell identifier]];
}

- (void)registerReuseViews
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <KTSectionModelProtocol> section in self.tableViewModel.datas) {
		if ([section respondsToSelector:@selector(headerModel)] &&
			[section.headerModel respondsToSelector:@selector(reuseViewClassName)] &&
			section.headerModel.reuseViewClassName) {
			Class cls = NSClassFromString(section.headerModel.reuseViewClassName);
			if (cls) {
				[set addObject:cls];
			}
		}
	}
	
	for (Class cellClass in [set allObjects]) {
		if ([cellClass conformsToProtocol:@protocol(KTTableCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:cellClass forHeaderFooterViewReuseIdentifier:[cellClass identifier]];
		}
	}
	
	[self.tableView registerClass:KTBaseTableReuseView.class forHeaderFooterViewReuseIdentifier:[KTBaseTableReuseView identifier]];
}

- (UITableViewStyle)tableViewStyle
{
	return UITableViewStylePlain;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableViewModel sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewModel rowCountWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = [self.tableViewModel reuseViewClassNameWithIndexPath:indexPath];
    NSString *identifierString = [NSClassFromString(className) identifier];
    if (vv_isEmptyStr(identifierString)) {
        NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
		identifierString = [KTBaseTableViewCell identifier];
	}
    KTBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.tableViewModel modelWithIndexPath:indexPath];
    cell.vv_model = model;
    [cell updateWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.tableViewModel reuseViewClassNameWithIndexPath:indexPath];
    id model = [self.tableViewModel modelWithIndexPath:indexPath];
    return [NSClassFromString(cellClassName) cellHeightWithModel:model];
}

/*
 - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSString *cellClassName = [self.tableViewModel reuseViewClasssNameWithIndexPath:indexPath];
 id model = [self.tableViewModel modelWithIndexPath:indexPath];
 return [NSClassFromString(cellClassName) estimateHeightWithModel:model];
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.tableViewModel reuseViewHeaderViewClassNameWithSection:section];
    id model = [self.tableViewModel modelOfReuseViewHeaderViewWithSection:section];
    return [NSClassFromString(reuseViewClassName) headerViewHeightWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.tableViewModel reuseViewFooterViewClassNameWithSection:section];
    id model = [self.tableViewModel modelOfReuseViewFooterViewWithSection:section];
    return [NSClassFromString(reuseViewClassName) footerViewHeightWithModel:model];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.tableViewModel reuseViewHeaderViewClassNameWithSection:section];
    KTBaseTableReuseView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSClassFromString(reuseViewClassName) identifier]];
    id model = [self.tableViewModel modelOfReuseViewHeaderViewWithSection:section];
    [headerView updateWithModel:model];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *reuseViewClassName = [self.tableViewModel reuseViewFooterViewClassNameWithSection:section];
    KTBaseTableReuseView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSClassFromString(reuseViewClassName) identifier]];
    id model = [self.tableViewModel modelOfReuseViewFooterViewWithSection:section];
    [footerView updateWithModel:model];
    return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.tableViewModel modelWithIndexPath:indexPath];
	[self tableView:tableView didSelectItem:model];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end
