//
//  KTTextListCellVM.h
//  KTListViewController
//
//  Created by KOTU on 2022/8/3.
//

#import "KTBaseReuseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTTextListCellVM : KTBaseReuseViewModel

@property (nonatomic, strong) NSMutableDictionary *widthCache;
@property (nonatomic, assign) UIControlState state;

@end

NS_ASSUME_NONNULL_END
