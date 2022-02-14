//
//  KTBaseCollectionCell.m
//  MVVMDemo
//
//  Created by KOTU on 2019/8/16.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionCell.h"
#import "KTBaseViewModel.h"

@implementation KTBaseCollectionReuseView

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

- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model
{
    
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end

@implementation KTBaseCollectionCell

@synthesize vv_model;
@dynamic viewModel;

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"%@_ID", NSStringFromClass(self)];
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
		[self loadInitialData];
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

- (void)loadInitialData
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

- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model
{
    
}

- (void)dealloc
{
    [self view_removeObservers];
}

@end
