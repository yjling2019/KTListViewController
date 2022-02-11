//
//  VVBaseContainerViewController.m
//  vv_bodylib_ios
//
//  Created by KOTU on 2019/12/13.
//

#import "VVBaseContainerViewController.h"
#import "VVBaseContainerView.h"
#import <Masonry/Masonry.h>

@interface VVBaseContainerViewController ()

@end

@implementation VVBaseContainerViewController
@synthesize vvContainerView = _vvContainerView;

- (Class)vc_registerContainerViewClass
{
    return [VVBaseContainerView class];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self vc_setUpUI];
    [self vc_setUpConstraints];
	[self vc_bindUIActions];
    [self vc_loadInitData];
	[self vc_loadInitialDataFromServer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vvContainerView container_viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.vvContainerView container_viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.vvContainerView container_viewWillDisappear:animated];
}

- (void)vc_setUpUI
{
    [self.view addSubview:self.vvContainerView];
}

- (void)vc_setUpConstraints
{
    [self.vvContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)vc_loadInitData
{
    [self.vvContainerView loadInitialData];
}

- (void)vc_bindUIActions
{
    [self.vvContainerView bindUIActions];
}

#pragma mark - getter
- (UIView<VVContainerViewProtocol> *)vvContainerView
{
    if (!_vvContainerView) {
        _vvContainerView = [[self vc_registerContainerViewClass] new];
    }
    return _vvContainerView;
}

@end
