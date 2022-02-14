//
//  KTListViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTListViewProtocol <KTViewProtocol>

@required
/// 如果view上有tableView或者collectionView的时候注册相关的cell
- (void)registerCells;
/// 如果view上有tableView或者collectionView的时候注册相关的ReuseView
- (void)registerReuseViews;

@optional
/// 设置tableView的样式
- (UITableViewStyle)tableViewStyle;
/// 设置collectionViewLayout
- (UICollectionViewLayout *)collectionViewLayout;

@end

NS_ASSUME_NONNULL_END