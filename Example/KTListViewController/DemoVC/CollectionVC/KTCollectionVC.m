//
//  KTCollectionVC.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionVC.h"
#import "KTCollectionVM.h"
#import <MJRefresh/MJRefresh.h>

@interface KTCollectionVC ()

@property (strong, nonatomic) KTCollectionVM *collectionViewModel;

@end

@implementation KTCollectionVC

@synthesize collectionViewModel = _collectionViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)kt_setUpUI
{
	[self.view addSubview:self.collectionView];
	self.collectionView.frame = self.view.bounds;
	self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)kt_loadInitialDataFromServer
{
	[self.collectionViewModel requestDataWithCompletion:^{
		[self.collectionView reloadData];
	}];
}

- (void)kt_pullRefresh
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.collectionView.mj_header endRefreshing];
	});
}

- (void)kt_loadMore
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.collectionView.mj_footer endRefreshing];
	});
}

- (UICollectionViewLayout *)kt_collectionViewLayout
{
	KTWaterfallFlowLayout *layout = [[KTWaterfallFlowLayout alloc] init];
	layout.delegate = self;
	return layout;
}

- (KTCollectionVM *)collectionViewModel
{
	if (!_collectionViewModel) {
		_collectionViewModel = [[KTCollectionVM alloc] init];
		_collectionViewModel.config.refreshHeaderClass = @"MJRefreshNormalHeader";
		_collectionViewModel.config.refreshFooterClass = @"MJRefreshAutoNormalFooter";
	}
	return _collectionViewModel;
}

@end
