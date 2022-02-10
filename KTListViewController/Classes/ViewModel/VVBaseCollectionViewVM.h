//
//  VVBaseCollectionViewVM.h
//  MVVMDemo
//
//  Created by JackLee on 2019/8/19.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVListVMProtocol.h"
#import "VVCollectionVMConfigProtocol.h"
#import "VVCollectionVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseCollectionVMConfig : NSObject<VVCollectionVMConfigProtocol>
 
@end

@interface VVBaseCollectionViewVM : NSObject<VVCollectionVMProtocol>

@end

NS_ASSUME_NONNULL_END
