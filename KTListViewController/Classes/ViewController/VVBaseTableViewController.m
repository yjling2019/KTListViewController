//
//  VVBaseTableViewController.m
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVBaseTableViewController.h"
#import "VVBaseViewModel.h"
#import "VVDataHelper.h"
#import <KVOController/KVOController.h>

@interface VVBaseTableViewController ()

@end

@implementation VVBaseTableViewController
@dynamic tableViewModel;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self vc_registerCells];
    [self vc_registerReuseViews];
    
    [self vc_setUpUI];
    [self vc_setUpConstraints];
    [self vc_bindUIActions];
	[self vc_addObservers];
	[self vc_loadInitData];
	[self vc_loadInitialDataFromServer];
}

#pragma mark - VVViewControllerProtocol
- (void)vc_setUpUI
{
    
}

- (void)vc_setUpConstraints
{
    
}

- (void)vc_loadInitData
{
    
}

- (void)vc_loadInitialDataFromServer
{
	
}

- (void)vc_bindUIActions
{
    
}

- (void)vc_addObservers
{
	[self.KVOController observe:self keyPath:@"tableViewModel.datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
		[self vc_registerCells];
		[self vc_registerReuseViews];
	}];
}

- (void)vc_removeObservers
{
	
}

#pragma mark - VVListViewControllerProtocol
- (void)vc_registerCells
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <VVSectionModelProtocol> section in self.tableViewModel.datas) {
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
		if ([cellClass conformsToProtocol:@protocol(VVTableCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass identifier]];
		}
	}
	
	[self.tableView registerClass:VVBaseTableViewCell.class
		   forCellReuseIdentifier:[VVBaseTableViewCell identifier]];
}

- (void)vc_registerReuseViews
{
	NSMutableSet *set = [NSMutableSet set];
	
	for (id <VVSectionModelProtocol> section in self.tableViewModel.datas) {
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
		if ([cellClass conformsToProtocol:@protocol(VVTableCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:cellClass forHeaderFooterViewReuseIdentifier:[cellClass identifier]];
		}
	}
	
	[self.tableView registerClass:VVBaseTableReuseView.class forHeaderFooterViewReuseIdentifier:[VVBaseTableReuseView identifier]];
}

- (void)vc_pullRefresh
{
	
}

- (void)vc_loadMore
{
	
}

- (UITableViewStyle)vc_tableViewStyle
{
	return UITableViewStylePlain;
}

#pragma mark - VVTableViewContainerProtocol
- (void)tableView:(UITableView *)tableView didSelectItem:(id <VVReuseViewModelProtocol>)item
{
	
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
		identifierString = [VVBaseTableViewCell identifier];
    }
    VVBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.tableViewModel modelWithIndexPath:indexPath];
    cell.vv_model = model;
    [cell updateWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate
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
    id model = [self.listViewModel modelWithIndexPath:indexPath];
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
    VVBaseTableReuseView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSClassFromString(reuseViewClassName) identifier]];
    id model = [self.tableViewModel modelOfReuseViewHeaderViewWithSection:section];
    [headerView updateWithModel:model];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   NSString *reuseViewClassName = [self.tableViewModel reuseViewFooterViewClassNameWithSection:section];
    VVBaseTableReuseView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSClassFromString(reuseViewClassName) identifier]];
    id model = [self.tableViewModel modelOfReuseViewFooterViewWithSection:section];
    [footerView updateWithModel:model];
    return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(addReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [cell respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)cell;
        [reuseView removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(VVReuseViewProtocol)]
        && [view respondsToSelector:@selector(removeReuseViewModelObservers)]) {
        UIView<VVReuseViewProtocol> *reuseView = (UIView<VVReuseViewProtocol> *)view;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self vc_tableViewStyle]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - dealloc
- (void)dealloc
{
	[self vc_removeObservers];
}

@end
