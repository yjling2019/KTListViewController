//
//  VVBaseCollectionCell.m
//  MVVMDemo
//
//  Created by JackLee on 2019/8/16.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import "VVBaseCollectionCell.h"
#import "VVBaseViewModel.h"

@implementation VVBaseCollectionReuseView
@synthesize vv_model;
@dynamic viewModel;

+ (NSString *)kind
{
    return UICollectionElementKindSectionHeader;
}

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

+ (CGSize)headerViewSizeWithModel:(id)model
{
    return CGSizeZero;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self setUpConstraints];
        [self bindUIActions];
        [self view_addObservers];
    }
    return self;
}

- (void)setUpUI
{
    
}

- (void)setUpConstraints
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

- (void)addReuseViewModelObservers
{
    
}

- (void)removeReuseViewModelObservers
{
    
}

- (void)updateWithModel:(id)model
{
    
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end

@implementation VVBaseCollectionCell
@synthesize vv_model;
@dynamic viewModel;

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

+ (CGSize)itemSizeWithModel:(id)model
{
    return CGSizeZero;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self setUpConstraints];
        [self bindUIActions];
        [self view_addObservers];
    }
    return self;
}

- (void)setUpUI
{
    
}

- (void)setUpConstraints
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

- (void)addReuseViewModelObservers
{
    
}

- (void)removeReuseViewModelObservers
{
    
}

- (void)updateWithModel:(id)model
{
    
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end
