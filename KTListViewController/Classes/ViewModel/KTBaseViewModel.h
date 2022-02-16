//
//  KTBaseViewModel.h
//  vv_bodylib_ios
//
//  Created by KOTU on 2020/7/13.
//

#import <Foundation/Foundation.h>
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseViewModel : NSObject <KTReuseViewModelProtocol>

/// 源数据，通常指api返回的数据
@property (nonatomic, strong, nullable) id rawData;

/// viewModel对应的视图的size
@property (nonatomic, assign) CGSize viewSize;

@end

NS_ASSUME_NONNULL_END
