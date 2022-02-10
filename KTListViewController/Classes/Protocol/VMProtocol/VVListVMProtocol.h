//
//  VVListVMProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>

#define KTSynthesizeListVMProtocol @synthesize hasMore = _hasMore;

NS_ASSUME_NONNULL_BEGIN

@protocol VVListVMProtocol <NSObject>

/// 是否还有更多可上拉刷新
@property (nonatomic, assign) BOOL hasMore;

/**
 用于tableView和CollectionView标识section的数量

 @return section的数量
 */
- (NSInteger)sectionCount;

/**
 根据indexPath获取Model，注意model只能是数据模型，不能是ViewModel

 @param indexPath indexPath
 @return 数据model
 */
- (nullable id)modelWithIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 根据indexPath获取对应的重用视图的类名

 @param indexPath indexPath
 @return viewModel
 */
- (nullable NSString *)reuseViewClassNameWithIndexPath:(nonnull NSIndexPath *)indexPath;

@optional

/// 获取某个setion对应的重用头视图数据模型
/// @param section section
- (nullable id)modelOfReuseViewHeaderViewWithSection:(NSInteger)section;

/// 获取某个section对应的重用尾视图数据模型
/// @param section section
- (nullable id)modelOfReuseViewFooterViewWithSection:(NSInteger)section;

/// 获取某个section对应的重用头视图类名
/// @param section section
- (nullable NSString *)reuseViewHeaderViewClassNameWithSection:(NSInteger)section;

/// 获取某个section对应的重用尾视图类名
/// @param section section
- (nullable NSString *)reuseViewFooterViewClassNameWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
