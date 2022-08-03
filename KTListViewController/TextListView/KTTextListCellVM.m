//
//  KTTextListCellVM.m
//  KTListViewController
//
//  Created by KOTU on 2022/8/3.
//

#import "KTTextListCellVM.h"

@implementation KTTextListCellVM

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.widthCache = [NSMutableDictionary dictionary];
	}
	return self;
}

@end
