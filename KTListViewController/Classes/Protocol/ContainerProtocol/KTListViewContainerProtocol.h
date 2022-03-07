//
//  KTListViewContainerProtocol.h
//  KOTU
//
//  Created by KOTU on 2019/9/19.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#ifndef KTListViewContainerProtocol_h
#define KTListViewContainerProtocol_h

#import "KTListVMProtocol.h"
#import <KTUILibrary/KTViewContainerProtocol.h>
#import "KTCollectionVMProtocol.h"
#import "KTTableVMProtocol.h"

@protocol KTListViewContainerProtocol <KTViewContainerProtocol>

@optional
/// 如果viewController上有tableView或者collectionView的时候注册相关的cell
- (void)kt_registerCells;

/// 如果viewController上有tableView或者collectionView的时候注册相关的ReuseView
- (void)kt_registerReuseViews;

/// 设置刷新头&尾
- (void)kt_setUpRefresher;

/// 下拉刷新
- (void)kt_pullRefresh;

/// 上拉加载更多
- (void)kt_loadMore;

/// 列表预加载
/// @param listView 列表页
/// @param indexPath indexPath
- (void)kt_preloadListView:(__kindof UIView *)listView atIndexPath:(NSIndexPath *)indexPath;

/// 点击事件处理
/// @param listView 列表页
/// @param item 点击的元素
- (void)kt_listView:(__kindof UIView *)listView didSelectItem:(id <KTReuseViewModelProtocol>)item;

@end

@protocol KTTableViewContainerProtocol<KTListViewContainerProtocol>

@required
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) __kindof id <KTTableVMProtocol> tableViewModel;

@optional
/// 设置tableView的样式
- (UITableViewStyle)kt_tableViewStyle;

@end

@protocol KTCollectionViewContainerProtocol<KTListViewContainerProtocol>

@required
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) __kindof id <KTCollectionVMProtocol> collectionViewModel;

@optional
/// 设置collectionViewLayout
- (UICollectionViewLayout *)kt_collectionViewLayout;

@end

#endif /* KTListViewContainerProtocol_h */
