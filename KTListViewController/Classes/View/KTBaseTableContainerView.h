//
//  KTBaseTableContainerView.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTBaseTableViewCell.h"
#import "KTBaseTableViewVM.h"
#import "KTViewProtocol.h"
#import "KTListViewProtocol.h"
#import "KTListViewContainerProtocol.h"
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableContainerView : UIView<UITableViewDataSource,
UITableViewDelegate,
KTViewProtocol,
KTListViewProtocol,
KTTableViewContainerProtocol>

- (void)reloadData;
- (nullable UITableViewCell *)cellOfReuseViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
