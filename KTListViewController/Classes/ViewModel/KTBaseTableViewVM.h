//
//  KTBaseTableViewVM.h
//  KOTU
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTListVMProtocol.h"
#import "KTTableVMProtocol.h"
#import "KTReuseViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableViewVM : NSObject<KTTableVMProtocol>

- (nullable NSIndexPath *)indexPathOfViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
