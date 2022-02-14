//
//  KTModelProtocol.h
//  vv_bodylib_ios
//
//  Created by KOTU on 2019/12/18.
//

#ifndef KTModelProtocol_h
#define KTModelProtocol_h

@protocol KTReuseViewModelProtocol <NSObject>

@optional

@property (nonatomic, copy, nullable) NSString *reuseViewClassName;

@end

typedef NS_ENUM(NSInteger, VVDecorationOriginType)
{
    /// sectionHeader的顶部
    VVDecorationOriginTypeSectionHeaderMin = 0,
    /// sectionHeader的底部
    VVDecorationOriginTypeSectionHeaderMax,
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

@end

#endif /* KTModelProtocol_h */