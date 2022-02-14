//
//  KTSimpleTableContainerView.h
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/5/18.
//

#import "KTBaseTableContainerView.h"
#import "KTTableVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTSimpleTableContainerView : KTBaseTableContainerView

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                     tableViewStyle:(UITableViewStyle)tableViewStyle
                     tableViewModel:(__kindof NSObject<KTTableVMProtocol>*)tableViewModel;

@end

NS_ASSUME_NONNULL_END
