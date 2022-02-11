//
//  VVTableVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVTableVMConfigProtocol.h"
#import "VVModelProtocol.h"

#define KTSynthesizeTableVMProtocol     @synthesize datas = _datas;\
                                        @synthesize config = _config;

NS_ASSUME_NONNULL_BEGIN

@protocol VVTableVMProtocol <VVListVMProtocol>

@required

@property (nonatomic, strong, nullable) NSArray <id <VVSectionModelProtocol>> *datas;
@property (nonatomic, strong) id <VVTableVMConfigProtocol> config;

/// 用于tableView标识每个section中row的数量
/// @param section ableView的section
- (NSInteger)rowCountWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
