//
//  KTTableVC.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTTableVC.h"
#import "KTTableContainerView.h"
#import "KTTableVM.h"

@interface KTTableVC ()
@property (strong, nonatomic) KTTableContainerView *containerView;
@property (strong, nonatomic) KTTableVM *tableViewModel;
@end

@implementation KTTableVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:self.containerView];
	self.containerView.tableViewModel = self.tableViewModel;
	self.containerView.frame = self.view.bounds;
	
	[self.tableViewModel requestDataWithCompletion:^{
		[self.containerView reloadData];
	}];
}

#pragma mark - lazy load
- (KTTableContainerView *)containerView
{
	if (!_containerView) {
		_containerView = [[KTTableContainerView alloc] init];
	}
	return _containerView;
}

- (KTTableVM *)tableViewModel
{
	if (!_tableViewModel) {
		_tableViewModel = [KTTableVM new];
	}
	return _tableViewModel;;
}

@end
