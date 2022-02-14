//
//  KTBaseCollectionViewController.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionCell.h"
#import "KTViewControllerProtocol.h"
#import "KTBaseCollectionViewVM.h"
#import "KTViewProtocol.h"
#import "KTListViewContainerProtocol.h"
#import "KTListViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate,
KTListViewControllerProtocol,
KTCollectionViewContainerProtocol>

@end

NS_ASSUME_NONNULL_END
