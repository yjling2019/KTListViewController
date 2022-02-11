//
//  VVBaseCollectionViewController.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "VVBaseCollectionCell.h"
#import "VVViewControllerProtocol.h"
#import "VVBaseCollectionViewVM.h"
#import "VVViewProtocol.h"
#import "VVListViewContainerProtocol.h"
#import "VVListViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseCollectionViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate,
VVListViewControllerProtocol,
VVCollectionViewContainerProtocol>

@end

NS_ASSUME_NONNULL_END
