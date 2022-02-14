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
@property (nonatomic, strong, nullable) id vv_rawData;

/// viewModel对应的视图的size
@property (nonatomic, assign) CGSize vv_size;

/// viewmodel对应的视图的link跳转
//@property (nonatomic, copy, nullable) NSString *vv_link;
/// viewmodel对应的视图的点击事件名字
//@property (nonatomic, copy, nullable) NSString *vv_eventName;
/// viewmodel对应的视图的点击事件需要传递的数据
//@property (nonatomic, strong, nullable) id vv_eventData;

@end

NS_ASSUME_NONNULL_END
