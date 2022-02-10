//
//  VVCollectionCellProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVCollectionCellProtocol <VVReuseViewProtocol>

@optional

/**
 单元格的size，根据model动态可变

 @param model 数据源
 @return size
 */
+ (CGSize)itemSizeWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
