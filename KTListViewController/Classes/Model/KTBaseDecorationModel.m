//
//  KTBaseDecorationModel.m
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/3/3.
//

#import "KTBaseDecorationModel.h"

@implementation KTBaseDecorationModel

@synthesize reuseViewClassName = _reuseViewClassName;
@synthesize insets = _insets;
@synthesize zIndex = _zIndex;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.zIndex = -1;
    }
    return self;
}

@end
