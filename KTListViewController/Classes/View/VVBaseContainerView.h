//
//  VVBaseContainerView.h
//  vv_bodylib_ios
//
//  Created by JackLee on 2019/12/13.
//

#import <UIKit/UIKit.h>
#import "VVContainerViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseContainerView : UIView<VVContainerViewProtocol>


/// 是否自动初始化 默认是
/// 如果是会默认自动调用如下方法
/*
 - (void)setUpUI;
 - (void)setUpConstraints;
 */
- (BOOL)vv_autoInit;

- (void)setUpUI;
- (void)setUpConstraints;

@end

NS_ASSUME_NONNULL_END
