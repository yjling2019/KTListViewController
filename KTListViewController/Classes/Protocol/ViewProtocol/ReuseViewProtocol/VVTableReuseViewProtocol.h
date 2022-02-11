//
//  VVTableReuseViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVTableReuseViewProtocol <VVReuseViewProtocol>

@optional
/// tableView区头高度
/// @param model 数据源
+ (CGFloat)headerViewHeightWithModel:(id)model;

/// tableView区头预估高度
/// @param model 数据源
+ (CGFloat)headerViewEstimateHeightWithModel:(id)model;

/// tableView区尾高度
/// @param model 数据源
+ (CGFloat)footerViewHeightWithModel:(id)model;

/// ableView区尾预估高度
/// @param model 数据源
+ (CGFloat)footerViewEstimateHeightWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
