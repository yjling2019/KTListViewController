//
//  VVBaseTableContainerView.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseTableViewCell.h"
#import "VVBaseTableViewVM.h"
#import "VVViewProtocol.h"
#import "VVListViewProtocol.h"
#import "VVListViewContainerProtocol.h"
#import "VVModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseTableContainerView : UIView<UITableViewDataSource,
UITableViewDelegate,
VVViewProtocol,
VVListViewProtocol,
VVTableViewContainerProtocol>

- (void)reloadData;
- (nullable UITableViewCell *)cellOfReuseViewModel:(id <VVReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
