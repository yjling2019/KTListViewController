//
//  KTBaseCollectionViewVM.h
//  KOTU
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTListVMProtocol.h"
#import "KTCollectionVMConfigProtocol.h"
#import "KTCollectionVMProtocol.h"
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionVMConfig : NSObject<KTCollectionVMConfigProtocol, KTCollectionLayoutConfigProtocol>
 
@end

@interface KTBaseCollectionViewVM : NSObject<KTCollectionVMProtocol>

- (nullable NSIndexPath *)indexPathOfViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
