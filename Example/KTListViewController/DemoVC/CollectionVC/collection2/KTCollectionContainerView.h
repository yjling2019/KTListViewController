//
//  KTCollectionContainerView.h
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/11.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import <KTListViewController/KTBaseCollectionContainerView.h>
#import "KTCollectionVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTCollectionContainerView : KTBaseCollectionContainerView
@property (strong, nonatomic) KTCollectionVM *collectionViewModel;
@end

NS_ASSUME_NONNULL_END
