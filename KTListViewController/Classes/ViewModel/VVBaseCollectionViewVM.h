//
//  VVBaseCollectionViewVM.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVListVMProtocol.h"
#import "VVCollectionVMConfigProtocol.h"
#import "VVCollectionVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseCollectionVMConfig : NSObject<VVCollectionVMConfigProtocol, VVCollectionLayoutConfigProtocol>
 
@end

@interface VVBaseCollectionViewVM : NSObject<VVCollectionVMProtocol>

- (nullable NSIndexPath *)indexPathOfViewModel:(id)vm;

@end

NS_ASSUME_NONNULL_END
