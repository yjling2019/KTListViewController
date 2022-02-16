//
//  KTPromptViewDataSource.h
//  KTListViewController
//
//  Created by KOTU on 2022/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KTPromptViewDataSource <NSObject>

@optional
- (UIView <KTPromptViewProtocol> *)kt_promptLoadingView;
- (UIView <KTPromptViewProtocol> *)kt_promptExceptionView;
- (UIView <KTPromptViewProtocol> *)kt_promptEmptyDataView;

@end

NS_ASSUME_NONNULL_END
