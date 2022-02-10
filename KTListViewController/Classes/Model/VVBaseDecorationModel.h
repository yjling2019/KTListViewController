//
//  VVBaseDecorationModel.h
//  vv_bodylib_ios
//
//  Created by admin on 2021/3/3.
//

#import <Foundation/Foundation.h>
#import "VVModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseDecorationModel : NSObject <VVDecorationViewModelProtocol>

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
