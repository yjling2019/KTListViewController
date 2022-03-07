//
//  KTReuseViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import <KTUILibrary/KTViewContainerProtocol.h>
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeReuseViewProtocol    @synthesize viewModel = _viewModel;\

@protocol KTReuseViewProtocol <KTViewContainerProtocol>

/// 视图对应的数据源
@property (nonatomic, strong) __kindof id <KTReuseViewModelProtocol> viewModel;

/// 重用的标识
+ (NSString *)identifier;

/// 为重用视图添加对应viewModel的监听,禁止开发者主动调用
- (void)kt_addReuseViewModelObservers;

/// 移除重用视图对应viewModel上的监听,禁止开发者主动调用
- (void)kt_removeReuseViewModelObservers;

/// 更新数据
/// @param model 数据模型
- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model;

@end

NS_ASSUME_NONNULL_END
