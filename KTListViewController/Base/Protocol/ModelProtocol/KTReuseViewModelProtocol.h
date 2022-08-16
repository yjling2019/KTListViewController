//
//  KTReuseViewModelProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2022/7/22.
//

#import <Foundation/Foundation.h>
#import "KTReuseViewModelProtocol.h"

#define KTSynthesizeReuseViewModelProtocol 	@synthesize reuseViewClassName = _reuseViewClassName;\
											@synthesize customIndex = _customIndex;\
											@synthesize isSelected = _isSelected;\
											@synthesize isEditing = _isEditing;\
											@synthesize isFirstItem = _isFirstItem;\
											@synthesize isLastItem = _isLastItem;\

NS_ASSUME_NONNULL_BEGIN

@protocol KTReuseViewModelProtocol <NSObject>

@optional

@property (nonatomic, copy, nullable) NSString *reuseViewClassName;

@property (nonatomic, assign) NSInteger customIndex;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, assign) BOOL isFirstItem;
@property (nonatomic, assign) BOOL isLastItem;

@end

NS_ASSUME_NONNULL_END
