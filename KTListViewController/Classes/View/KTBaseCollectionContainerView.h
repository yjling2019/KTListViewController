//
//  KTBaseCollectionContainerView.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTBaseCollectionCell.h"
#import "KTViewControllerProtocol.h"
#import "KTBaseCollectionViewVM.h"
#import "KTListViewContainerProtocol.h"
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionContainerView : UIView<UICollectionViewDataSource,
UICollectionViewDelegate,
KTCollectionViewContainerProtocol>

- (void)reloadData;
- (nullable UICollectionViewCell *)cellOfReuseViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
