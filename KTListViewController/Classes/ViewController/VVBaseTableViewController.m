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

@interface VVBaseTableViewController ()

@end

@implementation VVBaseTableViewController
@dynamic tableViewModel;
@synthesize tableView = _tableView;

- (NSArray <Class>*)vc_cellClasses
{
    if (self.tableViewModel.config.cellClassName && NSClassFromString(self.tableViewModel.config.cellClassName)) {
        return @[NSClassFromString(self.tableViewModel.config.cellClassName)];
    }
    return @[];
}

- (NSArray <Class>*)vc_resuseViewClasses
{
    NSMutableArray *array = [NSMutableArray new];
    if (self.tableViewModel.config.headerClassName && NSClassFromString(self.tableViewModel.config.headerClassName)) {
        [array addObject:NSClassFromString(self.tableViewModel.config.headerClassName)];
    }
    if (self.tableViewModel.config.footerClassName && NSClassFromString(self.tableViewModel.config.footerClassName)) {
        [array addObject:NSClassFromString(self.tableViewModel.config.footerClassName)];
    }
    return [array copy];
}

- (UITableViewStyle)vc_tableViewStyle
{
    return UITableViewStylePlain;
}

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

- (void)vc_bindUIActions
{
    
}

- (void)vc_addObservers
{
    
}

- (void)vc_removeObservers
{
	
}

#pragma mark - VVListViewControllerProtocol
- (void)vc_registerCells
{
	for (Class cellClass in [self vc_cellClasses]) {
		if ([cellClass conformsToProtocol:@protocol(VVTableCellProtocol)]
			&& [cellClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass identifier]];
		}
	}
}

- (void)vc_registerReuseViews
{
	for (Class reuseViewClass in [self vc_resuseViewClasses]) {
		if ([reuseViewClass conformsToProtocol:@protocol(VVTableReuseViewProtocol)]
			&& [reuseViewClass respondsToSelector:@selector(identifier)]) {
			[self.tableView registerClass:reuseViewClass forHeaderFooterViewReuseIdentifier:[reuseViewClass identifier]];
		}
	}
}

- (void)vc_pullRefresh
{
	
}

- (void)vc_loadMore
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
        return UITableViewCell.new;
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id model = [self.tableViewModel modelWithIndexPath:indexPath];
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
