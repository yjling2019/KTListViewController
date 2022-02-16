//
//  KTTableContainerView.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTTableContainerView.h"
#import <Masonry/Masonry.h>

@implementation KTTableContainerView

@synthesize tableViewModel = _tableViewModel;

- (void)kt_setUpUI
{
	self.backgroundColor = [UIColor redColor];
	
	[self addSubview:self.tableView];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(0);
	}];
}


@end
