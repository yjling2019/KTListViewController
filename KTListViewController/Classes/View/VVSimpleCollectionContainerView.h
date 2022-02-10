//
//  VVSimpleCollectionContainerView.h
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/5/18.
//

#import "VVBaseCollectionContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVSimpleCollectionContainerView : VVBaseCollectionContainerView

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                collectionViewModel:(__kindof NSObject<VVCollectionVMProtocol>*)collectionViewModel;

@end

NS_ASSUME_NONNULL_END
