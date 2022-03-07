//
//  KTBaseDecorationModel.h
//  KOTU
//
//  Created by KOTU on 2021/3/3.
//

#import <Foundation/Foundation.h>
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseDecorationModel : NSObject <KTDecorationViewModelProtocol>

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
