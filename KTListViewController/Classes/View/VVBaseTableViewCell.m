//
//  VVBaseTableViewCell.m
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVBaseTableViewCell.h"
#import "VVBaseViewModel.h"

@implementation VVBaseTableReuseView

@synthesize vv_model;
@dynamic viewModel;

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

+ (CGFloat)headerViewHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

+ (CGFloat)headerViewEstimateHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

+ (CGFloat)footerViewHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

+ (CGFloat)footerViewEstimateHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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


@implementation VVBaseTableViewCell

@synthesize vv_model;
@dynamic viewModel;

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

+ (CGFloat)estimateHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
