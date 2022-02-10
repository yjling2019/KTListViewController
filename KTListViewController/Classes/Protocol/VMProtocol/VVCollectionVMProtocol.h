//
//  VVCollectionVMProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVListVMProtocol.h"
#import "VVCollectionVMConfigProtocol.h"

#define KTSynthesizeCollectionVMProtocol    @synthesize datas = _datas;\
                                            @synthesize config = _config;

NS_ASSUME_NONNULL_BEGIN

@protocol VVCollectionVMProtocol <VVListVMProtocol>

@property (nonatomic, strong, nullable) __kindof NSArray *datas;
@property (nonatomic, strong, nonnull) __kindof NSObject<VVCollectionVMConfigProtocol> *config;

@required
/**
 用于tableView标识每个section中item的数量
 
 @param section collectionView的section
 @return item数量
 */
- (NSInteger)itemCountWithSection:(NSInteger)section;

/**
 每个section下单元格行间距
 
 @return 行间距
 */
- (CGFloat)itemMinLineSpacingWithSection:(NSInteger)section;

/**
 单元格列间距
 
 @return 列间距
 */
- (CGFloat)itemMinInterSpacingWithSection:(NSInteger)section;

/// 获取某个section的缩进
/// @param section section
- (UIEdgeInsets)sectionInsetsWithSection:(NSInteger)section;

/// 获取某个section的列数
/// @param section section
- (NSInteger)sectionColumnNumberWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
