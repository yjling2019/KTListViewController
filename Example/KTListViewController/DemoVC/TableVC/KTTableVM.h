//
//  KTTableVM.h
//  KTListViewController_Example
//
//  Created by 凌永剑 on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import <KTListViewController/VVBaseTableViewVM.h>
#import "VVBaseSectionModel.h"
#import "VVBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTTableVM : VVBaseTableViewVM

- (void)requestDataWithCompletion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
