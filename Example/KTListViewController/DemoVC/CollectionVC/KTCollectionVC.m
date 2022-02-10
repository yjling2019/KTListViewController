//
//  KTCollectionVC.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionVC.h"
#import "KTCollectionVM.h"

@interface KTCollectionVC ()

@property (strong, nonatomic) KTCollectionVM *collectionViewModel;

@end

@implementation KTCollectionVC

@synthesize collectionViewModel = _collectionViewModel;

- (NSArray<Class> *)vc_cellClasses
{
	return @[NSClassFromString(@"KTCollectionViewCell"), NSClassFromString(@"KTCollectionViewCell2")];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.view addSubview:self.collectionView];
	self.collectionView.frame = self.view.bounds;
	self.collectionView.backgroundColor = [UIColor whiteColor];
	
	[self.collectionViewModel requestDataWithCompletion:^{
		[self.collectionView reloadData];
	}];
}

- (KTCollectionVM *)collectionViewModel
{
	if (!_collectionViewModel) {
		_collectionViewModel = [[KTCollectionVM alloc] init];
		
		_collectionViewModel.config.isMultiSection = YES;
	}
	return _collectionViewModel;
}

@end
