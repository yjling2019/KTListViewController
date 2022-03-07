//
//  KTBaseTableViewController.m
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KTBaseTableViewController.h"
#import "KTBaseViewModel.h"
#import <KVOController/KVOController.h>
#import "UIScrollView+Preload.h"
#import <MJRefresh/MJRefresh.h>
#import <KTFoundation/NSArray+KTHelp.h>

static id <KTPromptViewDataSource> _globlePromptViewDataSource;

@interface KTBaseTableViewController ()

@end

@implementation KTBaseTableViewController

@dynamic tableViewModel;
@synthesize tableView = _tableView;
KTSynthesizePromptContainerProtocol

#pragma mark - KTViewControllerProtocol
+ (instancetype)kt_controller
{
	return [[[self class] alloc] init];
}

+ (instancetype)kt_controllerWithJSON:(NSDictionary *)json
{
	KTBaseTableViewController *controller = [self kt_controller];
	return controller;
}

+ (instancetype)kt_controllerWithModel:(id)model
{
	KTBaseTableViewController *controller = [self kt_controller];
	return controller;
}

#pragma mark - init override
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if ([self kt_autoSetup]) {
		[self kt_setUp];
	}
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
	[self kt_loadInitialDataFromServer];
	
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
	[self.KVOController observe:self keyPath:@"tableViewModel.datas" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
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
	[self.promptLoadingView showPromptViewInView:self.tableView];
}

- (void)kt_promptShowEmptyDataView
{
	[_promptEmptyDataView promptDismiss];
	[self.promptEmptyDataView showPromptViewInView:self.tableView];
}

- (void)kt_promptShowExceptionViewWithRefreshHandle:(void(^)(void))refreshBlock
{
	[_promptExceptionView promptDismiss];

	if ([self.promptExceptionView respondsToSelector:@selector(promptRefreshBlock)]) {
		self.promptExceptionView.promptRefreshBlock = refreshBlock;
	}
	
	[self.promptExceptionView showPromptViewInView:self.tableView];
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

#pragma mark - VVListViewControllerProtocol
- (void)kt_registerCells
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

- (void)kt_registerReuseViews
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

- (void)kt_setUpRefresher
{
	if ([self.tableViewModel.config respondsToSelector:@selector(refreshHeaderClass)] &&
		self.tableViewModel.config.refreshHeaderClass &&
		NSClassFromString(self.tableViewModel.config.refreshHeaderClass) &&
		[NSClassFromString(self.tableViewModel.config.refreshHeaderClass) respondsToSelector:@selector(headerWithRefreshingBlock:)] &&
		!self.tableView.mj_header) {
		
		__weak typeof(self) weakSelf = self;
		MJRefreshHeader *header = [NSClassFromString(self.tableViewModel.config.refreshHeaderClass) headerWithRefreshingBlock:^{
			[weakSelf kt_pullRefresh];
		}];
		self.tableView.mj_header = header;
	}
	
	if ([self.tableViewModel.config respondsToSelector:@selector(refreshFooterClass)] &&
		self.tableViewModel.config.refreshFooterClass &&
		NSClassFromString(self.tableViewModel.config.refreshFooterClass) &&
		[NSClassFromString(self.tableViewModel.config.refreshFooterClass) respondsToSelector:@selector(footerWithRefreshingBlock:)] &&
		!self.tableView.mj_footer) {
		
		__weak typeof(self) weakSelf = self;
		MJRefreshFooter *footer = [NSClassFromString(self.tableViewModel.config.refreshFooterClass) footerWithRefreshingBlock:^{
			[weakSelf kt_loadMore];
		}];
		self.tableView.mj_footer = footer;
	}
}

- (void)kt_pullRefresh
{
}

- (void)kt_loadMore
{
}

- (void)kt_preloadListView:(UITableView *)listView atIndexPath:(NSIndexPath *)indexPath
{
	if (![self.tableViewModel.config respondsToSelector:@selector(preloadMinCount)]) {
		return;
	}
	
	id <KTSectionModelProtocol> section = [self.tableViewModel.datas kt_objectAtIndex:indexPath.section];
	if (![section respondsToSelector:@selector(datas)]) {
		return;
	}
	
	[listView preloadWithCurrentItemIndex:indexPath.row totalDataCount:section.datas.count minCount:self.tableViewModel.config.preloadMinCount];
}

- (void)kt_listView:(UITableView *)listView didSelectItem:(id<KTReuseViewModelProtocol>)item
{
}

#pragma mark - KTTableViewContainerProtocol
- (UITableViewStyle)kt_tableViewStyle
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
    if (!identifierString) {
        NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
		identifierString = [KTBaseTableViewCell identifier];
    }
    KTBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    id model = [self.tableViewModel modelWithIndexPath:indexPath];
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
        && [view respondsToSelector:@selector(kt_addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView kt_addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(kt_addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
        [reuseView kt_addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(kt_addReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView kt_addReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(kt_removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView kt_removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [cell respondsToSelector:@selector(kt_removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)cell;
        [reuseView kt_removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view conformsToProtocol:@protocol(KTReuseViewProtocol)]
        && [view respondsToSelector:@selector(kt_removeReuseViewModelObservers)]) {
        UIView<KTReuseViewProtocol> *reuseView = (UIView<KTReuseViewProtocol> *)view;
        [reuseView kt_removeReuseViewModelObservers];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	id model = [self.tableViewModel modelWithIndexPath:indexPath];
	[self kt_listView:tableView didSelectItem:model];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self kt_tableViewStyle]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - dealloc override
- (void)dealloc
{
	[self kt_removeObservers];
}

@end
