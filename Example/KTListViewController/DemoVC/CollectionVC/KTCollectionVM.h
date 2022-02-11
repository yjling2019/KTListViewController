//
//  KTCollectionVM.h
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import <KTListViewController/VVBaseCollectionViewVM.h>
#import "VVBaseSectionModel.h"
#import "VVBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTCollectionVM : VVBaseCollectionViewVM

- (void)requestDataWithCompletion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
