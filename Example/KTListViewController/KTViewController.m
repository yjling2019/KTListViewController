//
//  KTViewController.m
//  KTListViewController
//
//  Created by KOTU on 12/10/2021.
//  Copyright (c) 2021 KOTU. All rights reserved.
//

#import "KTViewController.h"
#import "KTTableViewController.h"

@interface KTViewController ()
@property (strong, nonatomic) KTTableViewController *tableVC;
@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.view addSubview:self.tableVC.view];
	self.tableVC.view.frame = self.view.bounds;
}

- (KTTableViewController *)tableVC
{
	if (!_tableVC) {
		_tableVC = [[KTTableViewController alloc] init];
	}
	return _tableVC;
}

@end
