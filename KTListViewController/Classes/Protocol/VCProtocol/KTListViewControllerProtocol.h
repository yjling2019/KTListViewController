//
//  KTListViewControllerProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTListViewControllerProtocol <KTViewControllerProtocol>

@optional

/// 如果viewController上有tableView或者collectionView的时候注册相关的cell
- (void)vc_registerCells;

/// 如果viewController上有tableView或者collectionView的时候注册相关的ReuseView
- (void)vc_registerReuseViews;

/// 下拉刷新
- (void)vc_pullRefresh;

/// 上拉加载更多
- (void)vc_loadMore;

/// 预加载数据
/// @param indexPath indexPath
- (void)vc_preloadListView:(__kindof UIView *)listView atIndexPath:(NSIndexPath *)indexPath;

@optional

/// 设置tableView的样式
- (UITableViewStyle)vc_tableViewStyle;

/// 设置collectionViewLayout
- (UICollectionViewLayout *)vc_collectionViewLayout;

@end

NS_ASSUME_NONNULL_END
