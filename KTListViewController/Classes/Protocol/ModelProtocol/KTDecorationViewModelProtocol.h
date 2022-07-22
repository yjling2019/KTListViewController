//
//  KTDecorationViewModelProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2022/7/22.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KTDecorationOriginType)
{
	/// sectionHeader的顶部
	KTDecorationOriginTypeSectionHeaderMin = 0,
	/// sectionHeader的底部
	KTDecorationOriginTypeSectionHeaderMax,
};

@protocol KTDecorationViewModelProtocol <KTReuseViewModelProtocol>

/// DecorationView 区域的insets
@property (nonatomic, assign) UIEdgeInsets insets;

/// DecorationView 区域的zIndex
@property (nonatomic, assign) NSInteger zIndex;

@end

NS_ASSUME_NONNULL_END
