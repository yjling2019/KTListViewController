//
//  KTBaseTableViewController.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KTBaseTableViewCell.h"
#import "KTViewControllerProtocol.h"
#import "KTBaseTableViewVM.h"
#import "KTViewProtocol.h"
#import "KTListViewContainerProtocol.h"
#import "KTListViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,
KTListViewControllerProtocol,
KTTableViewContainerProtocol>

@end

NS_ASSUME_NONNULL_END
