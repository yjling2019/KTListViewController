//
//  KTBaseCollectionContainerView.h
//  KOTU
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTBaseCollectionCell.h"
#import "KTBaseCollectionViewVM.h"
#import "KTListViewContainerProtocol.h"
#import "KTModelProtocol.h"
#import "KTWaterfallFlowLayout.h"
#import "KTPromptProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionContainerView : UIView<UICollectionViewDataSource,
UICollectionViewDelegate,
KTCollectionViewContainerProtocol,
KTWaterfallFlowLayoutDelegate,
KTPromptProtocol,
KTPromptContainerProtocol>

- (void)reloadData;
- (nullable UICollectionViewCell *)cellOfReuseViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
