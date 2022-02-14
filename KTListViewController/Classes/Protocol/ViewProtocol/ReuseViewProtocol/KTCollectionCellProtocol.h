//
//  KTCollectionCellProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTCollectionCellProtocol <KTReuseViewProtocol>

@optional

/// 单元格的size，根据model动态可变
/// @param model 数据源
+ (CGSize)itemSizeWithModel:(id <KTReuseViewModelProtocol>)model;

@end

NS_ASSUME_NONNULL_END
