//
//  KTTableVMProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTSectionModelProtocol.h"

#define KTSynthesizeTableVMProtocol     @synthesize datas = _datas;\

NS_ASSUME_NONNULL_BEGIN

@protocol KTTableVMProtocol <KTListVMProtocol>

@required

@property (nonatomic, strong, nullable) NSArray <id <KTSectionModelProtocol>> *datas;

/// 用于tableView标识每个section中row的数量
/// @param section ableView的section
- (NSInteger)rowCountWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
