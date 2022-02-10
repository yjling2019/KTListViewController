//
//  VVBaseTableContainerView.h
//  MVVMDemo
//
//  Created by JackLee on 2019/8/17.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewCell.h"
#import "VVBaseTableViewVM.h"
#import "VVViewProtocol.h"
#import "VVListViewProtocol.h"
#import "VVListViewContainerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseTableContainerView : UIView<UITableViewDataSource,
UITableViewDelegate,
VVViewProtocol,
VVListViewProtocol,
VVTableViewContainerProtocol>

 /// 是否自动初始化 默认是
/// 如果是会默认自动调用如下方法
/*
 - (void)setUpUI;
 - (void)setUpConstraints;
 - (void)registerCells;
 - (void)registerReuseViews;
 - (void)bindUIActions;
 */
- (BOOL)vv_autoInit;

- (void)setUpUI;
- (void)setUpConstraints;
- (void)registerCells;
- (void)registerReuseViews;
- (void)bindUIActions;

@end

NS_ASSUME_NONNULL_END
