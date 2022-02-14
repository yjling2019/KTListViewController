//
//  KTCollectionVM.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionVM.h"

@interface KTCollectionVM ()

@end

@implementation KTCollectionVM

- (void)requestDataWithCompletion:(void (^)(void))completion
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0 ; i < 2 ; i++) {
			KTBaseSectionModel *sm = [[KTBaseSectionModel alloc] init];
			
			NSMutableArray *cells = [NSMutableArray array];
			for (int i = 0 ; i < 20 ; i++) {
				KTBaseViewModel *vm = [KTBaseViewModel new];
				if (i % 2 == 0) {
					vm.reuseViewClassName = @"KTCollectionViewCell";
				} else {
					vm.reuseViewClassName = @"KTCollectionViewCell2";
				}
				[cells addObject:vm];
			}
			sm.datas = cells.copy;
			[array addObject:sm];
		}
		self.datas = array.copy;
		completion();
	});
}

@end
