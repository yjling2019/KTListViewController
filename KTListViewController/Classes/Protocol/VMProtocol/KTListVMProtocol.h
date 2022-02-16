//
//  KTListVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTModelProtocol.h"

#define KTSynthesizeListVMProtocol @synthesize hasMore = _hasMore;\

NS_ASSUME_NONNULL_BEGIN

@protocol KTListVMProtocol <NSObject>

/// 是否还有更多可上拉刷新
@property (nonatomic, assign) BOOL hasMore;

/// 用于tableView和CollectionView标识section的数量
- (NSInteger)sectionCount;

/// 根据indexPath获取viewmodel
/// @param indexPath indexPath
- (nullable id <KTReuseViewModelProtocol>)modelWithIndexPath:(nonnull NSIndexPath *)indexPath;

/// 根据indexPath获取对应的重用视图的类名
/// @param indexPath indexPath
- (nullable NSString *)reuseViewClassNameWithIndexPath:(nonnull NSIndexPath *)indexPath;

@optional

/// 获取某个setion对应的重用头视图数据模型
/// @param section section
- (nullable id <KTReuseViewModelProtocol>)modelOfReuseViewHeaderViewWithSection:(NSInteger)section;

/// 获取某个section对应的重用尾视图数据模型
/// @param section section
- (nullable id <KTReuseViewModelProtocol>)modelOfReuseViewFooterViewWithSection:(NSInteger)section;

/// 获取某个section对应的重用头视图类名
/// @param section section
- (nullable NSString *)reuseViewHeaderViewClassNameWithSection:(NSInteger)section;

/// 获取某个section对应的重用尾视图类名
/// @param section section
- (nullable NSString *)reuseViewFooterViewClassNameWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
