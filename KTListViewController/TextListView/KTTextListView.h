//
//  KTTextListView.h
//  KTFoundation
//
//  Created by KOTU on 2022/8/3.
//

#import "KTBaseCollectionContainerView.h"
@class KTTextListView;

NS_ASSUME_NONNULL_BEGIN

@protocol KTTextListViewDelegate <NSObject>

@optional
- (void)textListView:(KTTextListView *)listView didSelectItemAtIndex:(NSInteger)index;

@end

@interface KTTextListView : KTBaseCollectionContainerView <KTViewContainerProtocol>

@property (nonatomic, weak) id <KTTextListViewDelegate> delegate;

@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) CGFloat itemExtraWidth;
@property (nonatomic, strong) NSNumber *itemMinWidth;
@property (nonatomic, strong) NSNumber *itemMaxWidth;
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

- (void)registerItemClass:(NSString *)className;
- (void)updateTextList:(NSArray <NSString *> *)texts;
- (void)setFont:(UIFont *)font forState:(UIControlState)state;

- (void)updateItemState:(UIControlState)state atIndex:(NSInteger)index;
- (void)kt_forceRefreshUI;

@end

NS_ASSUME_NONNULL_END
