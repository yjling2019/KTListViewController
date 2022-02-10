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

- (BOOL)vv_autoInit;

- (void)setUpUI;
- (void)setUpConstraints;
- (void)registerCells;
- (void)registerReuseViews;
- (void)bindUIActions;

- (nullable UITableViewCell *)cellOfViewModel:(id)vm;

@end

NS_ASSUME_NONNULL_END
