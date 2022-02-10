//
//  VVContainerViewProtocol.h
//  KTListViewController
//
//  Created by 凌永剑 on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVContainerViewProtocol <VVViewProtocol>

- (void)container_viewWillAppear:(BOOL)animated;
- (void)container_viewDidAppear:(BOOL)animated;
- (void)container_viewWillDisappear:(BOOL)animated;
- (void)container_viewDidDisappear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
