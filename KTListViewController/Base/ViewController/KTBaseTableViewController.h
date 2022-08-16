//
//  KTBaseTableViewController.h
//  KOTU
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KTBaseTableViewCell.h"
#import "KTViewControllerProtocol.h"
#import "KTBaseTableViewVM.h"
#import "KTListViewContainerProtocol.h"
#import "KTPromptProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,
KTViewControllerProtocol,
KTTableViewContainerProtocol,
KTPromptProtocol,
KTPromptContainerProtocol>

@end

NS_ASSUME_NONNULL_END
