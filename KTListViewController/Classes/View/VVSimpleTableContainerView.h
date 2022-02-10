//
//  VVSimpleTableContainerView.h
//  vv_bodylib_ios
//
//  Created by JackLee on 2021/5/18.
//

#import "VVBaseTableContainerView.h"
#import "VVTableVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVSimpleTableContainerView : VVBaseTableContainerView

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                     tableViewStyle:(UITableViewStyle)tableViewStyle
                     tableViewModel:(__kindof NSObject<VVTableVMProtocol>*)tableViewModel;

@end

NS_ASSUME_NONNULL_END
