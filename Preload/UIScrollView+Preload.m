//
//  UICollectionView+Preload.m
//  FloryDay
//
//  Created by Merlin on 2018/3/8.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import "UIScrollView+Preload.h"
#import <MJRefresh/MJRefresh.h>

static NSUInteger const kPreloadCollectionViewMinCount = 2;

@implementation UIScrollView (Preload)

- (void)preloadWithCurrentItemIndex:(NSUInteger)rowIndex totalDataCount:(NSUInteger)totalCount
{
    if (self.mj_footer &&
        rowIndex == totalCount - kPreloadCollectionViewMinCount &&
        self.mj_footer.state != MJRefreshStateNoMoreData &&
        self.mj_footer.state != MJRefreshStateRefreshing &&
        self.mj_header.state != MJRefreshStateRefreshing &&
        self.mj_header.state != MJRefreshStatePulling
        ) {
        [self.mj_footer beginRefreshing];
    }
}

- (void)preloadWithCurrentItemIndex:(NSUInteger)rowIndex
					 totalDataCount:(NSUInteger)totalCount
						   minCount:(NSInteger)minCount
{
    if (self.mj_footer &&
        rowIndex == totalCount - minCount &&
        self.mj_footer.state != MJRefreshStateNoMoreData &&
        self.mj_footer.state != MJRefreshStateRefreshing &&
        self.mj_header.state != MJRefreshStateRefreshing &&
        self.mj_header.state != MJRefreshStatePulling
        ) {
        [self.mj_footer beginRefreshing];
    }
}

@end
