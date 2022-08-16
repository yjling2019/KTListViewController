//
//  KTListVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewModelProtocol.h"
#import "KTListViewContextProtocol.h"

#define KTSynthesizeListVMProtocol 	@synthesize hasMore = _hasMore;\
									@synthesize preloadMinCount = _preloadMinCount;\
									@synthesize refreshHeaderClass = _refreshHeaderClass;\
									@synthesize refreshFooterClass = _refreshFooterClass;\

NS_ASSUME_NONNULL_BEGIN

@protocol KTListVMProtocol <NSObject>

@property (nonatomic, strong) id <KTListViewContextProtocol> kt_context;

#pragma mark - pull refresh
///// 是否支持下拉刷新
//@property (nonatomic, assign) BOOL supportPullRefresh;
/// 下拉刷新控件名
@property (nonatomic, strong) NSString *refreshHeaderClass;

#pragma mark - load more
///// 是否分页列表
//@property (nonatomic, assign) BOOL isPagingList;

/// 上拉加载控件名
@property (nonatomic, strong) NSString *refreshFooterClass;
/// 预加载最小间隔，即提前加载的数量
@property (nonatomic, assign) NSUInteger preloadMinCount;
/// 是否还有更多可上拉刷新
@property (nonatomic, assign) BOOL hasMore;

#pragma mark - reload
- (void)kt_reloadDatas;

#pragma mark - data source
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
