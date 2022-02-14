//
//  KTBaseTableViewCell.h
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTTableReuseViewProtocol.h"
#import "KTTableCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseTableReuseView : UITableViewHeaderFooterView<KTTableReuseViewProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

@interface KTBaseTableViewCell : UITableViewCell<KTTableCellProtocol>

@property (nonatomic, strong) __kindof NSObject *viewModel;

@end

NS_ASSUME_NONNULL_END
