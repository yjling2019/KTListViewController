//
//  VVListViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVListViewProtocol <VVViewProtocol>

@optional

/**
 如果view上有tableView或者collectionView的时候 注册的相关的cell的class列表
 */
- (NSArray <Class>*)cellClasses;

/**
 如果view上有tableView或者collectionView的时候 注册的相关的ReuseView的class列表
 */
- (NSArray <Class>*)resuseViewClasses;

/**
 如果view上有tableView或者collectionView的时候注册相关的cell
 */
- (void)registerCells;

/**
 如果view上有tableView或者collectionView的时候注册相关的ReuseView
 */
- (void)registerReuseViews;


@optional
/// 设置tableView的样式
- (UITableViewStyle)tableViewStyle;
/// 设置collectionViewLayout
- (UICollectionViewLayout *)collectionViewLayout;

@end

NS_ASSUME_NONNULL_END
