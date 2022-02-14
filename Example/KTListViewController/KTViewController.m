//
//  KTViewController.m
//  KTListViewController
//
//  Created by KOTU on 12/10/2021.
//  Copyright (c) 2021 KOTU. All rights reserved.
//

#import "KTViewController.h"
#import "KTTableViewController.h"
#import "KTCollectionVC.h"
#import "KTCollectionVC2.h"
#import "KTTableVC.h"

// TODO: 瀑布流layout、站位图

@interface KTViewController ()
@property (strong, nonatomic) KTTableViewController *tableVC;
@property (strong, nonatomic) KTTableVC *tableVC2;
@property (strong, nonatomic) KTCollectionVC *cvc;
@property (nonatomic, strong) KTCollectionVC2 *cvc2;
@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//继承base
	[self testTableVC];
	//继承containerview
//	[self testTableVC2];
	
	//继承base
//	[self testCollectionVC];
	//继承containerview
//	[self testCollectionVC2];
}

- (void)testTableVC
{
	[self.view addSubview:self.tableVC.view];
	self.tableVC.view.frame = self.view.bounds;
}

- (void)testTableVC2
{
	[self.view addSubview:self.tableVC2.view];
	self.tableVC2.view.frame = self.view.bounds;
}

- (void)testCollectionVC
{
	[self.view addSubview:self.cvc.view];
	self.cvc.view.frame = self.view.bounds;
}

- (void)testCollectionVC2
{
	[self.view addSubview:self.cvc2.view];
	self.cvc2.view.frame = self.view.bounds;
}

#pragma mark - lazy load
- (KTCollectionVC2 *)cvc2
{
	if (!_cvc2) {
		_cvc2 = [[KTCollectionVC2 alloc] init];
	}
	return _cvc2;
}

- (KTCollectionVC *)cvc
{
	if (!_cvc) {
		_cvc = [[KTCollectionVC alloc] init];
	}
	return _cvc;
}

- (KTTableVC *)tableVC2
{
	if (!_tableVC2) {
		_tableVC2 = [[KTTableVC alloc] init];
	}
	return _tableVC2;
}

- (KTTableViewController *)tableVC
{
	if (!_tableVC) {
		_tableVC = [[KTTableViewController alloc] init];
	}
	return _tableVC;
}

@end
