//
//  KTCollectionContainerView.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionContainerView.h"
#import <Masonry/Masonry.h>

@implementation KTCollectionContainerView

@synthesize collectionViewModel = _collectionViewModel;

- (void)kt_setUpUI
{
	self.backgroundColor = [UIColor redColor];
	
	[self addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(0);
	}];
}

- (void)kt_loadInitialDataFromServer
{
	[self kt_promptShowLoadingView];
	[self.collectionViewModel requestDataWithCompletion:^{
		BOOL success = arc4random()%2;
		if (success) {
			[self kt_promptDismiss];
			[self.collectionView reloadData];
		} else {
			[self kt_promptShowExceptionViewWithRefreshHandle:^{
				[self kt_loadInitialDataFromServer];
			}];
		}
	}];
}

- (void)kt_listView:(__kindof UIView *)listVie
	  didSelectItem:(id<KTReuseViewModelProtocol>)item
{
	NSLog(@"aaaaa");
}

- (UICollectionViewLayout *)kt_collectionViewLayout
{
	KTWaterfallFlowLayout *layout = [[KTWaterfallFlowLayout alloc] init];
	layout.delegate = self;
	return layout;
}

@end
