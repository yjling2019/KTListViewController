//
//  KTSimpleCollectionContainerView.h
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/5/18.
//

#import "KTBaseCollectionContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTSimpleCollectionContainerView : KTBaseCollectionContainerView

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                collectionViewModel:(__kindof NSObject<KTCollectionVMProtocol>*)collectionViewModel;

@end

NS_ASSUME_NONNULL_END
