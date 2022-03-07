//
//  KTCustomCollectionViewLayout.h
//  KOTU
//
//  Created by KOTU on 2019/5/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KTWaterfallFlowLayout;

@protocol KTWaterfallFlowLayoutDelegate <NSObject>

@required
// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView
					 layout:(KTWaterfallFlowLayout *)collectionViewLayout
	  columnNumberAtSection:(NSInteger)section;

// cell height
- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout *)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
				itemWidth:(CGFloat)itemWidth;

@optional
// header height
- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout *)collectionViewLayout
referenceHeightForHeaderInSection:(NSInteger)section;

// footer height
- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout *)collectionViewLayout
referenceHeightForFooterInSection:(NSInteger)section;

// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
						layout:(KTWaterfallFlowLayout*)collectionViewLayout
		insetForSectionAtIndex:(NSInteger)section;

// 每个区内部的垂直距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout *)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section;

// 每个区内部的水平距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(KTWaterfallFlowLayout*)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section;

///使用配置的contentSize，和  customContentSize方法配合使用
/// 这时候使用代理方法配置的contentSize
- (BOOL)useCustomContentSize;

///  配置的contentSize
- (CGSize)customContentSize;

@end

@interface KTWaterfallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id <KTWaterfallFlowLayoutDelegate> delegate;

@property (nonatomic, assign) CGFloat minimumLineSpacing; // default 0.0
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; // default 0.0
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds; // default NO
@property (nonatomic, assign) CGFloat contentOffsetY;

/// 未悬停的header的布局属性
- (UICollectionViewLayoutAttributes *)originLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

/// 获取cell的布局属性
/// @param indexPath cell的indexpath
- (UICollectionViewLayoutAttributes *)originLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
