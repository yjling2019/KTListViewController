//
//  KTCollectionVMConfigProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define KTSynthesizeCollectionVMConfigProtocol \


#define KTSynthesizeCollectionLayoutConfigProtocol \
@synthesize lineSpace = _lineSpace;\
@synthesize interSpace = _interSpace;\
@synthesize sectionInsets = _sectionInsets;\
@synthesize columnNumber = _columnNumber;\


@protocol KTCollectionVMConfigProtocol <NSObject>

@optional

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
