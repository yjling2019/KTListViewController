//
//  KTSectionModelProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2022/7/22.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewModelProtocol.h"
#import "KTDecorationViewModelProtocol.h"

#define KTSynthesizeSectionModelProtocol 	@synthesize datas = _datas;\
											@synthesize decorationModel = _decorationModel;\
											@synthesize headerModel = _headerModel;\
											@synthesize footerModel = _footerModel;\
											@synthesize columnNumber = _columnNumber;\
											@synthesize minimumLineSpacing = _minimumLineSpacing;\
											@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;\
											@synthesize sectionInsets = _sectionInsets;\
											@synthesize sectionType = _sectionType;\

NS_ASSUME_NONNULL_BEGIN

@protocol KTSectionModelProtocol <NSObject>

@optional

/// 分区列表的数据源
@property (nonatomic, strong, nullable) __kindof NSArray <id <KTReuseViewModelProtocol>> *datas;

@property (nonatomic, strong, nullable) __kindof NSObject <KTDecorationViewModelProtocol> *decorationModel;

/// 分区区头的数据源
@property (nonatomic, strong, nullable) __kindof NSObject <KTReuseViewModelProtocol> *headerModel;

/// 分区区尾的数据源
@property (nonatomic, strong, nullable) __kindof NSObject <KTReuseViewModelProtocol> *footerModel;

/// 分区列数
@property (nonatomic, assign) NSInteger columnNumber;

/// 每个分区的lineSpacing
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/// 每个分区的interitemSpacing
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/// 每个分区的sectionInsets
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

/// 分区类型，用于区分section，自定义
@property (nonatomic, assign) NSInteger sectionType;

@end

NS_ASSUME_NONNULL_END
