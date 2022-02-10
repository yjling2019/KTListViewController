//
//  VVBaseCollectionContainerView.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
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

- (void)registerCells;
- (void)registerReuseViews;

- (void)setUpUI;
- (void)setUpConstraints;
- (void)bindUIActions;

- (nullable UICollectionViewCell *)cellOfViewModel:(id)vm;

@end

NS_ASSUME_NONNULL_END
