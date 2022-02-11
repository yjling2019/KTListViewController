//
//  VVContainerViewControllerProtocol.h
//  KTListViewController
//
//  Created by KOTU on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import "VVViewControllerProtocol.h"
#import "VVContainerViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VVContainerViewControllerProtocol <VVViewControllerProtocol>

@property (nonatomic, strong) __kindof UIView<VVContainerViewProtocol> *vvContainerView;

- (Class)vc_registerContainerViewClass;

@end

NS_ASSUME_NONNULL_END
