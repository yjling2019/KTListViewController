//
//  KTTableVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTTableVMConfigProtocol.h"
#import "KTModelProtocol.h"

#define KTSynthesizeTableVMProtocol     @synthesize datas = _datas;\
                                        @synthesize config = _config;

NS_ASSUME_NONNULL_BEGIN

@protocol KTTableVMProtocol <KTListVMProtocol>

@required

@property (nonatomic, strong, nullable) NSArray <id <KTSectionModelProtocol>> *datas;
@property (nonatomic, strong) id <KTTableVMConfigProtocol> config;

/// 用于tableView标识每个section中row的数量
/// @param section ableView的section
- (NSInteger)rowCountWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
