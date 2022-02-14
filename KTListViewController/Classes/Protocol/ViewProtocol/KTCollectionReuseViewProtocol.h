//
//  KTCollectionReuseViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTCollectionReuseViewProtocol <KTReuseViewProtocol>

/// section头视图的kind 类型
/// 只能为 UICollectionElementKindSectionHeader 或 UICollectionElementKindSectionFooter
+ (NSString *)kind;

@optional
/// section头视图的size，根据model动态可变
/// @param model 数据源
+ (CGSize)headerViewSizeWithModel:(id <KTReuseViewModelProtocol>)model;

/// section尾视图的size，根据model动态可变
/// @param model 数据源
+ (CGSize)footerViewSizeWithModel:(id <KTReuseViewModelProtocol>)model;

@end

NS_ASSUME_NONNULL_END
