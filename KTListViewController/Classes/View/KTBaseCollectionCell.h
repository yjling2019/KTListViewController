//
//  KTBaseCollectionCell.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTViewProtocol.h"
#import "KTCollectionReuseViewProtocol.h"
#import "KTCollectionCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionReuseView : UICollectionReusableView<KTCollectionReuseViewProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

@interface KTBaseCollectionCell : UICollectionViewCell<KTCollectionCellProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

NS_ASSUME_NONNULL_END
