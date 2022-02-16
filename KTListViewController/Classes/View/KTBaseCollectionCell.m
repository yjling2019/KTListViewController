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

@dynamic viewModel;

#pragma mark - KTCollectionReuseViewProtocol
+ (NSString *)kind
{
    return UICollectionElementKindSectionHeader;
}

+ (CGSize)headerViewSizeWithModel:(id<KTReuseViewModelProtocol>)model
{
    return CGSizeZero;
}

+ (CGSize)footerViewSizeWithModel:(id<KTReuseViewModelProtocol>)model
{
	return CGSizeZero;
}

#pragma mark - init override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

@implementation KTBaseCollectionCell

@dynamic viewModel;

#pragma mark - KTCollectionCellProtocol
+ (CGSize)itemSizeWithModel:(id)model
{
	return CGSizeZero;
}

#pragma mark - init override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
	return [NSString stringWithFormat:@"%@_ID", NSStringFromClass(self)];
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
