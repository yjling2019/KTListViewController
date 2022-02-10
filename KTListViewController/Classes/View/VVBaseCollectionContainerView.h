//
//  VVBaseCollectionContainerView.h
//  MVVMDemo
//
//  Created by JackLee on 2019/8/17.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBaseCollectionCell.h"
#import "VVViewControllerProtocol.h"
#import "VVBaseCollectionViewVM.h"
#import "VVViewProtocol.h"
#import "VVListViewContainerProtocol.h"
#import "VVListViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseCollectionContainerView : UIView<UICollectionViewDataSource,
UICollectionViewDelegate,
VVListViewProtocol,
VVCollectionViewContainerProtocol>

- (BOOL)vv_autoInit;

- (void)setUpUI;
- (void)setUpConstraints;
- (void)registerCells;
- (void)registerReuseViews;
- (void)bindUIActions;

@end

NS_ASSUME_NONNULL_END
