//
//  KTBaseReuseViewModel.h
//  Kiwi
//
//  Created by KOTU on 2020/10/14.
//

#import "KTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTBaseReuseViewModel : KTBaseViewModel <KTReuseViewModelProtocol>

@property (nonatomic, strong) id customData;

@end

NS_ASSUME_NONNULL_END
