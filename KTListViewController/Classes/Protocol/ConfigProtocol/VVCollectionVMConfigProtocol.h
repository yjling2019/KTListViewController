//
//  VVCollectionVMConfigProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeCollectionVMConfigProtocol \
@synthesize cellClassName = _cellClassName;\
@synthesize headerClassName = _headerClassName;\
@synthesize footerClassName = _footerClassName;\
@synthesize lineSpace = _lineSpace;\
@synthesize interSpace = _interSpace;\
@synthesize sectionInsets = _sectionInsets;\
@synthesize columnNumber = _columnNumber;\
@synthesize isMultiSection = _isMultiSection;\
@synthesize isMultiCell = _isMultiCell;\
@synthesize headerModel = _headerModel;\
@synthesize footerModel = _footerModel;

@protocol VVCollectionVMConfigProtocol <NSObject>

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

/// collectionView对应的lineSpace
@property (nonatomic, assign) CGFloat lineSpace;

/// collectionView对应的interSpace
@property (nonatomic, assign) CGFloat interSpace;

/// collectionView对应的sectionInsets
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

/// collectionView对应的列数
@property (nonatomic, assign) NSInteger columnNumber;

/// 是否是多section，默认为NO
@property (nonatomic, assign) BOOL isMultiSection;

/// 是否是多种类型cell
@property (nonatomic, assign, readonly) BOOL isMultiCell;

@end

NS_ASSUME_NONNULL_END
