//
//  VVPromptDelegate.h
//  VVBodyLib
//
//  Created by KOTU on 2019/6/17.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KTPromptRefreshBlock)(void);

@protocol KTPromptViewDataSource;

#define KTSynthesizePromptContainerProtocol \
@synthesize promptViewDataSource = _promptViewDataSource;\
@synthesize promptLoadingView = _promptLoadingView;\
@synthesize promptExceptionView = _promptExceptionView;\
@synthesize promptEmptyDataView = _promptEmptyDataView;\

@protocol KTPromptContainerProtocol <NSObject>

@optional
+ (void)kt_setupGlobalPromptViewDataSource:(id <KTPromptViewDataSource>)dataSource;

@property (strong, nonatomic) id <KTPromptViewDataSource> promptViewDataSource;
@property (strong, nonatomic) UIView *promptLoadingView;
@property (strong, nonatomic) UIView *promptExceptionView;
@property (strong, nonatomic) UIView *promptEmptyDataView;

@end

@protocol KTPromptProtocol <NSObject>

@optional
- (void)kt_promptShowLoadingView;
- (void)kt_promptShowEmptyDataView;
- (void)kt_promptShowExceptionViewWithRefreshHandle:(KTPromptRefreshBlock)refreshBlock;

- (void)kt_promptDismiss;

@end

@protocol KTPromptViewDataSource <NSObject>

@optional
- (UIView *)kt_promptLoadingView;
- (UIView *)kt_promptExceptionView;
- (UIView *)kt_promptEmptyDataView;

@end


NS_ASSUME_NONNULL_END
