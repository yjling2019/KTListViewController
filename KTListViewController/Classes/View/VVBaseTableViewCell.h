//
//  VVBaseTableViewCell.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVTableReuseViewProtocol.h"
#import "VVTableCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseTableReuseView : UITableViewHeaderFooterView<VVTableReuseViewProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

@interface VVBaseTableViewCell : UITableViewCell<VVTableCellProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

NS_ASSUME_NONNULL_END
