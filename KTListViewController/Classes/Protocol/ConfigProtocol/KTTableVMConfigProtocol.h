//
//  KTTableVMConfigProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeTableVMConfigProtocol \
@synthesize preloadMinCount = _preloadMinCount;\

@protocol KTTableVMConfigProtocol <NSObject>

@optional

/// 预加载最小间隔，即提前加载的数量
@property (nonatomic, assign) NSUInteger preloadMinCount;

/// 下拉刷新控件名
@property (nonatomic, strong) NSString *refreshHeaderClass;
/// 上拉加载控件名
@property (nonatomic, strong) NSString *refreshFooterClass;

@end

NS_ASSUME_NONNULL_END
