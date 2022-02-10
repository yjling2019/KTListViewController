//
//  VVTableVMConfigProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeTableVMConfigProtocol \
@synthesize cellClassName = _cellClassName;\
@synthesize headerClassName = _headerClassName;\
@synthesize footerClassName = _footerClassName;\
@synthesize headerModel = _headerModel;\
@synthesize footerModel = _footerModel;\

@protocol VVTableVMConfigProtocol <NSObject>

@optional

/// cell类名
@property (nonatomic, copy, nullable) NSString *cellClassName;

/// 分区区头类名
@property (nonatomic, copy, nullable) NSString *headerClassName;

/// 分区区尾类名
@property (nonatomic, copy, nullable) NSString *footerClassName;

/// 分区区头的数据源
@property (nonatomic, strong, nullable) __kindof NSObject *headerModel;

/// 分区区尾的数据源
@property (nonatomic, strong, nullable) __kindof NSObject *footerModel;

@end

NS_ASSUME_NONNULL_END
