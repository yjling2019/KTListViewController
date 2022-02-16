//
//  KTBaseTableViewVM.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTListVMProtocol.h"
#import "KTTableVMConfigProtocol.h"
#import "KTTableVMProtocol.h"
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableVMConfig : NSObject<KTTableVMConfigProtocol>

@end

@interface KTBaseTableViewVM : NSObject<KTTableVMProtocol>

- (nullable NSIndexPath *)indexPathOfViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
