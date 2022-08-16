//
//  KTBaseCollectionCell.h
//  KOTU
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTCollectionReuseViewProtocol.h"
#import "KTCollectionCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseCollectionReuseView : UICollectionReusableView<KTCollectionReuseViewProtocol>

@end

@interface KTBaseCollectionCell : UICollectionViewCell<KTCollectionCellProtocol>

@end

NS_ASSUME_NONNULL_END
