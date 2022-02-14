//
//  KTContainerViewProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "KTViewProtocol.h"
#import "KTModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTContainerViewProtocol <KTViewProtocol>

@optional
- (void)container_viewWillAppear:(BOOL)animated;
- (void)container_viewDidAppear:(BOOL)animated;
- (void)container_viewWillDisappear:(BOOL)animated;
- (void)container_viewDidDisappear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END