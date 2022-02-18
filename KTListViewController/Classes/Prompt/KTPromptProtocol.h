//
//  VVPromptDelegate.h
//  VVBodyLib
//
//  Created by KOTU on 2019/6/17.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTPromptViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^KTPromptRefreshBlock)(void);

@protocol KTPromptViewProtocol;

#define KTSynthesizePromptContainerProtocol \
@synthesize promptViewDataSource = _promptViewDataSource;\
@synthesize promptLoadingView = _promptLoadingView;\
@synthesize promptExceptionView = _promptExceptionView;\
@synthesize promptEmptyDataView = _promptEmptyDataView;\

#define KTSynthesizePromptViewProtocol \
@synthesize promptRefreshBlock = _promptRefreshBlock;\
@synthesize showInView = _showInView;\

@protocol KTPromptContainerProtocol <NSObject>

@optional
+ (void)kt_setupGlobalPromptViewDataSource:(id <KTPromptViewDataSource>)dataSource;

@property (strong, nonatomic) id <KTPromptViewDataSource> promptViewDataSource;
@property (strong, nonatomic) UIView <KTPromptViewProtocol> *promptLoadingView;
@property (strong, nonatomic) UIView <KTPromptViewProtocol> *promptExceptionView;
@property (strong, nonatomic) UIView <KTPromptViewProtocol> *promptEmptyDataView;

@end

@protocol KTPromptProtocol <NSObject>

@optional
- (void)kt_promptShowLoadingView;
- (void)kt_promptShowEmptyDataView;
- (void)kt_promptShowExceptionViewWithRefreshHandle:(KTPromptRefreshBlock)refreshBlock;
//- (void)kt_promptShowExceptionView:(NSException *)exception
//					 refreshHandle:(KTPromptRefreshBlock)refreshBlock;

- (void)kt_promptDismiss;

@end

@protocol KTPromptViewProtocol <NSObject>

@optional
@property (strong, nonatomic, nullable) KTPromptRefreshBlock promptRefreshBlock;
@property (weak, nonatomic) UIView *showInView;

@required
- (void)showPromptViewInView:(UIView *)showInView;
- (void)promptDismiss;

@end

NS_ASSUME_NONNULL_END
