//
//  VVBaseTableContainerView.m
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "VVBaseTableContainerView.h"
#import "VVDataHelper.h"

@implementation VVBaseTableContainerView

@dynamic tableViewModel;
@synthesize tableView = _tableView;

- (NSArray <Class>*)cellClasses
{
    if (self.tableViewModel.config.cellClassName && NSClassFromString(self.tableViewModel.config.cellClassName)) {
        return @[NSClassFromString(self.tableViewModel.config.cellClassName)];
    }
    return @[];
}

- (NSArray <Class>*)resuseViewClasses
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

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

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

- (nullable UITableViewCell *)cellOfViewModel:(id)vm
{
	if (!vm) {
		return nil;
	}
	
	NSIndexPath *indexPath;
	
	for (VVBaseTableViewVM *sectionVM in self.tableViewModel.datas) {
		NSInteger item = [sectionVM.datas indexOfObject:vm];
		if (item == NSNotFound) {
			continue;
		}
		
		NSInteger section = [self.tableViewModel.datas indexOfObject:sectionVM];
		if (section == NSNotFound) {
			NSAssert(NO, @"VVBaseCollectionViewVM: section not found, maybe self.datas changed");
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

#pragma mark -
- (void)registerCells
{
    for (Class cellClass in [self cellClasses]) {
        if ([cellClass conformsToProtocol:@protocol(VVTableCellProtocol)]
             && [cellClass respondsToSelector:@selector(identifier)]) {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass identifier]];
        }
    }
}

- (void)registerReuseViews
{
    for (Class reuseViewClass in [self resuseViewClasses]) {
        if ([reuseViewClass conformsToProtocol:@protocol(VVTableReuseViewProtocol)]
            && [reuseViewClass respondsToSelector:@selector(identifier)]) {
            [self.tableView registerClass:reuseViewClass forHeaderFooterViewReuseIdentifier:[reuseViewClass identifier]];
        }
   }
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
#if DEBUG
        NSAssert(NO, @"vv_bodylib_ios error: empty reuse identifier");
#endif
        return UITableViewCell.new;
    }
    VVBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
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

#pragma mark - - getter - -
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
