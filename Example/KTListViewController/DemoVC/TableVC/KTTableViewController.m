//
//  KTTableViewController.m
//  KTListViewController_Example
//
//  Created by 凌永剑 on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import "KTTableViewController.h"
#import "KTTableVM.h"

@interface KTTableViewController ()
@property (strong, nonatomic) KTTableVM *tableViewModel;
@end

@implementation KTTableViewController

@synthesize tableViewModel = _tableViewModel;

- (NSArray<Class> *)vc_cellClasses
{
	return @[NSClassFromString(@"KTTableCell")];
}

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

#pragma mark - lazy load
- (KTTableVM *)tableViewModel
{
	if (!_tableViewModel) {
		_tableViewModel = [[KTTableVM alloc] init];
	}
	return _tableViewModel;
}

@end
