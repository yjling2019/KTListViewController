//
//  KTTableVM.h
//  KTListViewController_Example
//
//  Created by KOTU on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import <KTListViewController/KTBaseTableViewVM.h>
#import "KTBaseSectionModel.h"
#import "KTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTTableVM : KTBaseTableViewVM

- (void)requestDataWithCompletion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
