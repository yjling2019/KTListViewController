//
//  KTBaseCollectionViewController.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionCell.h"
#import "KTViewControllerProtocol.h"
#import "KTListViewContainerProtocol.h"
#import "KTBaseCollectionViewVM.h"
#import "KTWaterfallFlowLayout.h"
#import "KTPromptProtocol.h"
#import "KTPromptViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate,
KTViewControllerProtocol,
KTCollectionViewContainerProtocol,
KTWaterfallFlowLayoutDelegate,
KTPromptProtocol,
KTPromptContainerProtocol>

@end

NS_ASSUME_NONNULL_END
