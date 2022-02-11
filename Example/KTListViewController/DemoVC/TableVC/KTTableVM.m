//
//  KTTableVM.m
//  KTListViewController_Example
//
//  Created by KOTU on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import "KTTableVM.h"

@interface KTTableVM ()
@property (nonatomic, strong) VVBaseSectionModel *section;
@end

@implementation KTTableVM

@synthesize config = _config;

- (__kindof NSObject<VVTableVMConfigProtocol> *)config
{
	if (!_config) {
		_config = [VVBaseTableVMConfig new];
	}
	return _config;
}

- (void)requestDataWithCompletion:(void (^)(void))completion
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0 ; i < 100 ; i++) {
			VVBaseSectionModel *sm = [[VVBaseSectionModel alloc] init];
			VVBaseViewModel *vm = [VVBaseViewModel new];
			vm.reuseViewClassName = @"KTTableCell";
			sm.datas = @[vm];
			[array addObject:sm];
		}
		self.datas = array.copy;
		completion();
	});
}

@end
