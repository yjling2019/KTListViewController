//
//  KTViewProtocol.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "KTViewProtocol.h"
#import "KTModelProtocol.h"

#ifndef KTViewProtocol_h
#define KTViewProtocol_h

@protocol KTViewProtocol <NSObject>

@optional

/// 根据配置创建视图
/// @param config 配置
+ (instancetype)view_initWithConfig:(id)config;

/// 配置view以及subViews
- (void)setUpUI;

/// 设置约束
- (void)setUpConstraints;

/// 加载初始化数据
- (void)loadInitialData;

/// 绑定UI事件
- (void)bindUIActions;

/// 添加监听，init的时候添加监听
- (void)view_addObservers;

/// 移除监听，dealloc的时候移除监听
- (void)view_removeObservers;

/// 根据数据源更新视图
/// @param model 数据源
- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model;

/// 下拉刷新
- (void)pullRefresh;

/// 下载加载更多
- (void)loadMore;

@end

#endif /* KTViewProtocol_h */