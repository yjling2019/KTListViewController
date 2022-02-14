//
//  KTViewControllerProtocol.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "KTViewProtocol.h"

#ifndef KTViewControllerProtocol_h
#define KTViewControllerProtocol_h

@protocol KTViewControllerInitProtocol <NSObject>

@optional

/// 使用类方法进行初始化
+ (instancetype)vc_controller;

/// 使用类方法根据json对象初始化
/// @param json json对象
+ (instancetype)vc_controllerWithJSON:(NSDictionary *)json;

///  使用类方法根据model初始化
/// @param model 数据模型
+ (instancetype)vc_controllerWithModel:(id)model;

@end

@protocol KTViewControllerProtocol <KTViewControllerInitProtocol>

@optional
/// 控制器中配置视图
- (void)vc_setUpUI;

/// 控制器中配置约束
- (void)vc_setUpConstraints;

/// 控制器中绑定ui事件
- (void)vc_bindUIActions;

/// 控制器中加载Init数据
- (void)vc_loadInitialData;

/// 控制器从接口加载Init数据
- (void)vc_loadInitialDataFromServer;

/// 控制器中刷新UI
- (void)vc_refreshUI;

/// 添加监听，viewDidload时添加
- (void)vc_addObservers;

/// 移除监听，dealloc时移除
- (void)vc_removeObservers;

@end

#endif /* KTViewControllerProtocol_h */