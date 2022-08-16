//
//  VVPromptDelegate.h
//  KOTU
//
//  Created by KOTU on 2019/6/17.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTPromptViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^KTPromptBlock)(void);

@protocol KTPromptViewProtocol;

#define KTSynthesizePromptContainerProtocol \
@synthesize promptViewDataSource = _promptViewDataSource;\
@synthesize promptLoadingView = _promptLoadingView;\
@synthesize promptExceptionView = _promptExceptionView;\
@synthesize promptEmptyDataView = _promptEmptyDataView;\

#define KTSynthesizePromptViewProtocol \
@synthesize promptActionBlock = _promptActionBlock;\
@synthesize showInView = _showInView;\

@protocol KTPromptContainerProtocol <NSObject>

@optional
+ (void)kt_setupGlobalPromptViewDataSource:(id <KTPromptViewDataSource>)dataSource;

@property (nonatomic, strong) id <KTPromptViewDataSource> promptViewDataSource;
@property (nonatomic, strong) UIView <KTPromptViewProtocol> *promptLoadingView;
@property (nonatomic, strong) UIView <KTPromptViewProtocol> *promptExceptionView;
@property (nonatomic, strong) UIView <KTPromptViewProtocol> *promptEmptyDataView;

@end

@protocol KTPromptProtocol <NSObject>

@optional
- (BOOL)kt_autoShowEmptyView;

- (void)kt_promptShowLoadingView;
- (void)kt_promptShowEmptyDataView;
- (void)kt_promptShowEmptyDataViewWithActionHandle:(KTPromptBlock)actionBlock;
- (void)kt_promptShowExceptionViewWithRefreshHandle:(KTPromptBlock)refreshBlock;
//- (void)kt_promptShowExceptionView:(NSException *)exception
//					 refreshHandle:(KTPromptRefreshBlock)refreshBlock;

- (void)kt_promptDismiss;

@end

@protocol KTPromptViewProtocol <NSObject>

@optional
@property (nonatomic, strong, nullable) KTPromptBlock promptActionBlock;
@property (nonatomic, weak) UIView *showInView;

@required
- (void)showPromptViewInView:(UIView *)showInView;
- (void)promptDismiss;

@end

NS_ASSUME_NONNULL_END
