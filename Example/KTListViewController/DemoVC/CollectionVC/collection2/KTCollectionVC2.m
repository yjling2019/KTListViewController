//
//  KTCollectionVC2.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionVC2.h"
#import "KTCollectionContainerView.h"
#import "KTCollectionVM.h"
#import <Masonry/Masonry.h>

@interface KTCollectionVC2 ()
@property (strong, nonatomic) KTCollectionContainerView *containerView;
@property (strong, nonatomic) KTCollectionVM *collectionViewModel;
@end

@implementation KTCollectionVC2

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.view addSubview:self.containerView];
	self.containerView.collectionViewModel = self.collectionViewModel;
//	self.containerView.frame = self.view.bounds;
	[self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(0);
	}];
	
	[self.containerView kt_loadInitialDataFromServer];
	
//	[self.collectionViewModel requestDataWithCompletion:^{
//		[self.containerView reloadData];
//	}];
}

#pragma mark - lazy load
- (KTCollectionContainerView *)containerView
{
	if (!_containerView) {
		_containerView = [[KTCollectionContainerView alloc] init];
	}
	return _containerView;
}

- (KTCollectionVM *)collectionViewModel
{
	if (!_collectionViewModel) {
		_collectionViewModel = [KTCollectionVM new];
	}
	return _collectionViewModel;;
}

@end
