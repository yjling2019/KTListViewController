//
//  KTModelProtocol.h
//  KOTU
//
//  Created by KOTU on 2019/12/18.
//

#ifndef KTModelProtocol_h
#define KTModelProtocol_h

#define KTSynthesizeReuseViewModelProtocol 	@synthesize reuseViewClassName = _reuseViewClassName;\
											@synthesize customIndex = _customIndex;\
											@synthesize isSelected = _isSelected;\
											@synthesize isEditing = _isEditing;\
											@synthesize isFirstItem = _isFirstItem;\
											@synthesize isLastItem = _isLastItem;\

#define KTSynthesizeSectionModelProtocol 	@synthesize datas = _datas;\
											@synthesize decorationModel = _decorationModel;\
											@synthesize headerModel = _headerModel;\
											@synthesize footerModel = _footerModel;\
											@synthesize columnNumber = _columnNumber;\
											@synthesize minimumLineSpacing = _minimumLineSpacing;\
											@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;\
											@synthesize sectionInsets = _sectionInsets;\
											@synthesize sectionType = _sectionType;\

@protocol KTReuseViewModelProtocol <NSObject>

@optional

@property (nonatomic, copy, nullable) NSString *reuseViewClassName;

@property (nonatomic, assign) NSInteger customIndex;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, assign) BOOL isFirstItem;
@property (nonatomic, assign) BOOL isLastItem;

@end

typedef NS_ENUM(NSInteger, KTDecorationOriginType)
{
    /// sectionHeader的顶部
    KTDecorationOriginTypeSectionHeaderMin = 0,
    /// sectionHeader的底部
    KTDecorationOriginTypeSectionHeaderMax,
};

@protocol KTDecorationViewModelProtocol <NSObject, KTReuseViewModelProtocol>

/// DecorationView 区域的insets
@property (nonatomic, assign) UIEdgeInsets insets;

/// DecorationView 区域的zIndex
@property (nonatomic, assign) NSInteger zIndex;

@end

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

#endif /* KTModelProtocol_h */
