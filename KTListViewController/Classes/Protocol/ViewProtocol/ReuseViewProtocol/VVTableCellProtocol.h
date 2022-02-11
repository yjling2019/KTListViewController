//
//  VVTableCellProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVTableCellProtocol <VVReuseViewProtocol>

@optional

/// 单元格的高度，根据model动态可变
/// @param model 数据源
+ (CGFloat)cellHeightWithModel:(id)model;

/// 单元格的预估高度，根据model动态可变
/// @param model 数据源
+ (CGFloat)estimateHeightWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
