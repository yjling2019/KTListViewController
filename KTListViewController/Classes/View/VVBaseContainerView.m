//
//  VVBaseContainerView.m
//  vv_bodylib_ios
//
//  Created by JackLee on 2019/12/13.
//

#import "VVBaseContainerView.h"

@implementation VVBaseContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self vv_autoInit]) {
            [self setUpUI];
            [self setUpConstraints];
            [self bindUIActions];
            [self view_addObservers];
        }
    }
    return self;
}

- (BOOL)vv_autoInit
{
    return YES;
}

- (void)setUpUI
{
    
}

- (void)setUpConstraints
{
    
}

- (void)loadInitData
{
    
}

- (void)bindUIActions
{
    
}

- (void)view_addObservers
{
    
}

- (void)view_removeObservers
{
    
}

- (void)container_viewWillAppear:(BOOL)animated
{
    
}

- (void)container_viewDidAppear:(BOOL)animated
{
    
}

- (void)container_viewWillDisappear:(BOOL)animated
{
    
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end
