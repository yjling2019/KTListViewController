//
//  KTBaseTableContainerView.h
//  KOTU
//
//  Created by KOTU on 2019/8/17.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTBaseTableViewCell.h"
#import "KTBaseTableViewVM.h"
#import "KTListViewContainerProtocol.h"
#import "KTModelProtocol.h"
#import "KTPromptProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableContainerView : UIView<UITableViewDataSource,
UITableViewDelegate,
KTTableViewContainerProtocol,
KTPromptContainerProtocol>

- (void)reloadData;
- (nullable UITableViewCell *)cellOfReuseViewModel:(id <KTReuseViewModelProtocol>)vm;

@end

NS_ASSUME_NONNULL_END
