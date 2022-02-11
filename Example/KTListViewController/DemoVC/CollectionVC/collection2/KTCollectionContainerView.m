//
//  KTCollectionContainerView.m
//  KTListViewController_Example
//
//  Created by 凌永剑 on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionContainerView.h"
#import <Masonry/Masonry.h>

@implementation KTCollectionContainerView

@synthesize collectionViewModel = _collectionViewModel;

- (void)setUpUI
{
	self.backgroundColor = [UIColor redColor];
	
	[self addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(0);
	}];
}

@end
