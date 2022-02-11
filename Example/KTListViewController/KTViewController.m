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

@interface KTViewController ()
@property (strong, nonatomic) KTTableViewController *tableVC;
@property (strong, nonatomic) KTCollectionVC *cvc;
@property (nonatomic, strong) KTCollectionVC2 *cvc2;
@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self testTableVC];
//	[self testCollectionVC];
//	[self testCollectionVC2];
}

- (void)testTableVC
{
	[self.view addSubview:self.tableVC.view];
	self.tableVC.view.frame = self.view.bounds;
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

- (KTTableViewController *)tableVC
{
	if (!_tableVC) {
		_tableVC = [[KTTableViewController alloc] init];
	}
	return _tableVC;
}

@end
