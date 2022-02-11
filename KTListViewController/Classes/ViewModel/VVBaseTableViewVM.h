//
//  VVBaseTableViewVM.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVListVMProtocol.h"
#import "VVTableVMConfigProtocol.h"
#import "VVTableVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseTableVMConfig : NSObject<VVTableVMConfigProtocol>

@end

@interface VVBaseTableViewVM : NSObject<VVTableVMProtocol>

- (nullable NSIndexPath *)indexPathOfViewModel:(id)vm;

@end

NS_ASSUME_NONNULL_END
