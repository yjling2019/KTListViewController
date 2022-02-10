//
//  VVBaseTableViewController.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVBaseTableViewCell.h"
#import "VVViewControllerProtocol.h"
#import "VVBaseTableViewVM.h"
#import "VVViewProtocol.h"
#import "VVListViewContainerProtocol.h"
#import "VVListViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseTableViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,
VVListViewControllerProtocol,
VVTableViewContainerProtocol>

@end

NS_ASSUME_NONNULL_END
