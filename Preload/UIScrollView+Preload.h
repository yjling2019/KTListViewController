//
//  UICollectionView+Preload.h
//  FloryDay
//
//  Created by KOTU on 2018/3/8.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Preload)

/**
 添加预加载功能

 @param rowIndex 当前滚动行数（cellforitem 的indexpath.row 参数）
 @param totalCount 当前列表数据源数量
 */
- (void)preloadWithCurrentItemIndex:(NSUInteger)rowIndex
					 totalDataCount:(NSUInteger)totalCount;

/// 添加预加载功能
/// @param rowIndex 当前滚动的行数
/// @param totalCount 当前的数据源数量
/// @param minCount 预加的临界值,距离最后一个cell的间隔
- (void)preloadWithCurrentItemIndex:(NSUInteger)rowIndex
					 totalDataCount:(NSUInteger)totalCount
						   minCount:(NSInteger)minCount;

@end
