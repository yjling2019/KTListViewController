//
//  VVBaseDecorationModel.m
//  vv_bodylib_ios
//
//  Created by admin on 2021/3/3.
//

#import "VVBaseDecorationModel.h"

@implementation VVBaseDecorationModel

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
