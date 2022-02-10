//
//  VVReuseViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeReuseViewProtocol    @synthesize vv_model = _vv_model;\

@protocol VVReuseViewProtocol <VVViewProtocol>

/// 视图对应的数据源
@property (nonatomic, strong) __kindof NSObject *vv_model;
/**
 重用是的标识
 
 @return 标识
 */
+ (NSString *)identifier;

/// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
- (void)addReuseViewModelObservers;

/// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
- (void)removeReuseViewModelObservers;

@end

NS_ASSUME_NONNULL_END
