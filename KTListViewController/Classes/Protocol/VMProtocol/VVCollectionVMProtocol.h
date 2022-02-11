//
//  VVCollectionVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVListVMProtocol.h"
#import "VVCollectionVMConfigProtocol.h"
#import "VVModelProtocol.h"

#define KTSynthesizeCollectionVMProtocol    @synthesize datas = _datas;\
                                            @synthesize config = _config;

NS_ASSUME_NONNULL_BEGIN

@protocol VVCollectionVMProtocol <VVListVMProtocol>

@required

@property (nonatomic, strong, nullable) NSArray <id <VVSectionModelProtocol>> *datas;
@property (nonatomic, strong) id <VVCollectionVMConfigProtocol, VVCollectionLayoutConfigProtocol> config;

/// 用于collectionView标识每个section中item的数量
/// @param section section
- (NSInteger)itemCountWithSection:(NSInteger)section;

/// 每个section下单元格行间距
/// @param section section
- (CGFloat)itemMinLineSpacingWithSection:(NSInteger)section;

/// 单元格列间距
/// @param section section
- (CGFloat)itemMinInterSpacingWithSection:(NSInteger)section;

/// 获取某个section的缩进
/// @param section section
- (UIEdgeInsets)sectionInsetsWithSection:(NSInteger)section;

/// 获取某个section的列数
/// @param section section
- (NSInteger)sectionColumnNumberWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
