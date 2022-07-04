//
//  KTBaseSectionModel.h
//  KOTU
//
//  Created by KOTU on 2019/12/19.
//

#import <Foundation/Foundation.h>
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseSectionModel : NSObject<KTSectionModelProtocol>

/// 源数据，通常指api返回的数据
@property (nonatomic, strong, nullable) id rawData;

@property (nonatomic, strong, nullable) id customData;

@end

NS_ASSUME_NONNULL_END
