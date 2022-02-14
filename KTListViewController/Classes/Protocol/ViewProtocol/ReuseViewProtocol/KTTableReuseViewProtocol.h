//
//  KTTableReuseViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTTableReuseViewProtocol <KTReuseViewProtocol>

@optional
/// tableView区头高度
/// @param model 数据源
+ (CGFloat)headerViewHeightWithModel:(id <KTReuseViewModelProtocol>)model;

/// tableView区头预估高度
/// @param model 数据源
+ (CGFloat)headerViewEstimateHeightWithModel:(id <KTReuseViewModelProtocol>)model;

/// tableView区尾高度
/// @param model 数据源
+ (CGFloat)footerViewHeightWithModel:(id <KTReuseViewModelProtocol>)model;

/// ableView区尾预估高度
/// @param model 数据源
+ (CGFloat)footerViewEstimateHeightWithModel:(id <KTReuseViewModelProtocol>)model;

@end

NS_ASSUME_NONNULL_END
