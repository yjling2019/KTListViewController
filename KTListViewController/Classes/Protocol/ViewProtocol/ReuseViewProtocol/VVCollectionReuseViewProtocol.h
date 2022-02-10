//
//  VVCollectionReuseViewProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVCollectionReuseViewProtocol <VVReuseViewProtocol>

/// section头视图的kind 类型
/// 只能为 UICollectionElementKindSectionHeader 或 UICollectionElementKindSectionFooter
+ (NSString *)kind;

@optional

/**
 section头视图的size，根据model动态可变

 @param model 数据源
 @return size
 */
+ (CGSize)headerViewSizeWithModel:(id)model;

/**
 section尾视图的size，根据model动态可变
 
 @param model 数据源
 @return size
 */
+ (CGSize)footerViewSizeWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
