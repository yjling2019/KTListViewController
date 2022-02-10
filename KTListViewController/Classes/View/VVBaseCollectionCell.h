//
//  VVBaseCollectionCell.h
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVViewProtocol.h"
#import "VVCollectionReuseViewProtocol.h"
#import "VVCollectionCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseCollectionReuseView : UICollectionReusableView<VVCollectionReuseViewProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

@interface VVBaseCollectionCell : UICollectionViewCell<VVCollectionCellProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

NS_ASSUME_NONNULL_END
