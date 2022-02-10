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

@interface KTViewController ()
@property (strong, nonatomic) KTTableViewController *tableVC;
@property (strong, nonatomic) KTCollectionVC *cvc;
@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
//	[self testTableVC];
	[self testCollectionVC];
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
