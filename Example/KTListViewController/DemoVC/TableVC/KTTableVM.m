//
//  KTTableVM.m
//  KTListViewController_Example
//
//  Created by KOTU on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import "KTTableVM.h"

@interface KTTableVM ()
@property (nonatomic, strong) KTBaseSectionModel *section;
@end

@implementation KTTableVM

- (void)requestDataWithCompletion:(void (^)(void))completion
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0 ; i < 100 ; i++) {
			KTBaseSectionModel *sm = [[KTBaseSectionModel alloc] init];
			KTBaseViewModel *vm = [KTBaseViewModel new];
			vm.reuseViewClassName = @"KTTableCell";
			sm.datas = @[vm];
			[array addObject:sm];
		}
		self.datas = array.copy;
		completion();
	});
}

@end
