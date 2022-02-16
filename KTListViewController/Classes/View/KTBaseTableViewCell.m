//
//  KTBaseTableViewCell.m
//  VOVA
//
//  Created by KOTU on 2019/8/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KTBaseTableViewCell.h"
#import "KTBaseViewModel.h"

@implementation KTBaseTableReuseView

@dynamic viewModel;

#pragma mark - KTTableReuseViewProtocol
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

#pragma mark - init override
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
		if ([self kt_autoSetup]) {
			[self kt_setUp];
		}
	}
	return self;
}

#pragma mark - KTViewContainerProtocol
- (BOOL)kt_autoSetup
{
	return YES;
}

- (void)kt_setUp
{
	[self kt_setUpUI];
	[self kt_setUpConstraints];
	[self kt_bindUIActions];
	[self kt_loadInitialData];
	[self kt_addObservers];
}

#pragma mark - KTViewContainerProtocol
- (void)kt_setUpUI
{
}

- (void)kt_setUpConstraints
{
}

- (void)kt_bindUIActions
{
}

- (void)kt_loadInitialData
{
}

- (void)kt_loadInitialDataFromServer
{
}

- (void)kt_refreshUI
{
}

- (void)kt_addObservers
{
}

- (void)kt_removeObservers
{
}

#pragma mark - KTReuseViewProtocol
+ (NSString *)identifier
{
	return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

- (void)kt_addReuseViewModelObservers
{
}

- (void)kt_removeReuseViewModelObservers
{
}

- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model
{
    
}

#pragma mark - dealloc override
- (void)dealloc
{
    [self kt_removeObservers];
}

@end


@implementation KTBaseTableViewCell

@dynamic viewModel;

#pragma mark - KTTableCellProtocol
+ (CGFloat)cellHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

+ (CGFloat)estimateHeightWithModel:(id)model
{
    return UITableViewAutomaticDimension;
}

#pragma mark - init override
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		if ([self kt_autoSetup]) {
			[self kt_setUp];
		}
	}
	return self;
}

#pragma mark - KTViewContainerProtocol
- (BOOL)kt_autoSetup
{
	return YES;
}

- (void)kt_setUp
{
	[self kt_setUpUI];
	[self kt_setUpConstraints];
	[self kt_bindUIActions];
	[self kt_loadInitialData];
	[self kt_addObservers];
}

- (void)kt_setUpUI
{
}

- (void)kt_setUpConstraints
{
}

- (void)kt_bindUIActions
{
}

- (void)kt_loadInitialData
{
}

- (void)kt_loadInitialDataFromServer
{
}

- (void)kt_refreshUI
{
}

- (void)kt_addObservers
{
}

- (void)kt_removeObservers
{
}

#pragma mark - KTReuseViewProtocol
+ (NSString *)identifier
{
	return [NSString stringWithFormat:@"%@_ID",NSStringFromClass(self)];
}

- (void)kt_addReuseViewModelObservers
{
}

- (void)kt_removeReuseViewModelObservers
{
}

- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model
{
}

#pragma mark - dealloc override
- (void)dealloc
{
    [self kt_removeObservers];
}

@end
