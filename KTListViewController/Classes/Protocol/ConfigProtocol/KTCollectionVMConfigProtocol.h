//
//  KTCollectionVMConfigProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeCollectionVMConfigProtocol \
@synthesize preloadMinCount = _preloadMinCount;\

#define KTSynthesizeCollectionLayoutConfigProtocol \
@synthesize lineSpace = _lineSpace;\
@synthesize interSpace = _interSpace;\
@synthesize sectionInsets = _sectionInsets;\
@synthesize columnNumber = _columnNumber;\

@protocol KTCollectionVMConfigProtocol <NSObject>

@optional
/// 预加载最小间隔，即提前加载的数量
@property (nonatomic, assign) NSUInteger preloadMinCount;

/// 下拉刷新控件名
@property (nonatomic, strong) NSString *refreshHeaderClass;
/// 上拉加载控件名
@property (nonatomic, strong) NSString *refreshFooterClass;

@end


@protocol KTCollectionLayoutConfigProtocol <NSObject>

@optional

/// collectionView对应的lineSpace
@property (nonatomic, assign) CGFloat lineSpace;

/// collectionView对应的interSpace
@property (nonatomic, assign) CGFloat interSpace;

/// collectionView对应的sectionInsets
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

/// collectionView对应的列数
@property (nonatomic, assign) NSInteger columnNumber;

@end

NS_ASSUME_NONNULL_END
