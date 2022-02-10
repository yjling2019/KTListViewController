//
//  VVTableVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVTableVMConfigProtocol.h"

#define KTSynthesizeTableVMProtocol     @synthesize datas = _datas;\
                                        @synthesize config = _config;

NS_ASSUME_NONNULL_BEGIN

@protocol VVTableVMProtocol <VVListVMProtocol>

@property (nonatomic, strong, nullable) __kindof NSArray *datas;
@property (nonatomic, strong, nonnull) __kindof NSObject<VVTableVMConfigProtocol> *config;

@required
/**
 用于tableView标识每个section中row的数量
 
 @param section tableView的section
 @return row数量
 */
- (NSInteger)rowCountWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
