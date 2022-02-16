//
//  KTTableViewController.m
//  KTListViewController_Example
//
//  Created by KOTU on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import "KTTableViewController.h"
#import "KTTableVM.h"
#import <MJRefresh/MJRefresh.h>

@interface KTTableViewController ()
@property (strong, nonatomic) KTTableVM *tableViewModel;
@end

@implementation KTTableViewController

@synthesize tableViewModel = _tableViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.view addSubview:self.tableView];
	self.tableView.frame = self.view.bounds;
	self.tableView.backgroundColor = [UIColor whiteColor];
	
	[self.tableViewModel requestDataWithCompletion:^{
		[self.tableView reloadData];
	}];
}

- (void)kt_listView:(__kindof UIView *)listView didSelectItem:(id<KTReuseViewModelProtocol>)item
{
	NSLog(@"aaaa");
}

- (void)kt_pullRefresh
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.tableView.mj_header endRefreshing];
	});
}

- (void)kt_loadMore
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.tableView.mj_footer endRefreshing];
	});
}

#pragma mark - lazy load
- (KTTableVM *)tableViewModel
{
	if (!_tableViewModel) {
		_tableViewModel = [[KTTableVM alloc] init];
	}
	return _tableViewModel;
}

@end
