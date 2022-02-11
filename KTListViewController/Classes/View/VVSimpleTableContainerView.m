//
//  VVSimpleTableContainerView.m
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/5/18.
//

#import "VVSimpleTableContainerView.h"
#import <Masonry/Masonry.h>

@interface VVSimpleTableContainerView()

@property (nonatomic, strong) NSArray <Class>*simple_cellClasses;
@property (nonatomic, strong) NSArray <Class> *simple_reuseViewClasses;
@property (nonatomic, strong) __kindof id<VVTableVMProtocol> tableViewModel;
@property (nonatomic, assign) UITableViewStyle simple_tableViewStyle;

@end

@implementation VVSimpleTableContainerView
@synthesize tableViewModel;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                     tableViewStyle:(UITableViewStyle)tableViewStyle
                     tableViewModel:(__kindof NSObject<VVTableVMProtocol>*)tableViewModel
{
    NSAssert(cellClasses.count > 0, @"make sure cellClasses.count > 0");

	VVSimpleTableContainerView *containerView = [[super alloc] init];
    containerView.simple_cellClasses = cellClasses;
    containerView.simple_reuseViewClasses = reuseViewClasses;
    containerView.simple_tableViewStyle = tableViewStyle;
    containerView.tableViewModel = tableViewModel;
    [containerView registerCells];
    [containerView registerReuseViews];
    [containerView setUpUI];
    [containerView setUpConstraints];
	[containerView bindUIActions];
    return containerView;
}

- (NSArray<Class> *)cellClasses
{
    return self.simple_cellClasses;
}

- (NSArray<Class> *)resuseViewClasses
{
    return self.simple_reuseViewClasses;
}

- (UITableViewStyle)tableViewStyle
{
    return self.simple_tableViewStyle;
}

- (void)setUpUI
{
    [self addSubview:self.tableView];
}

- (void)setUpConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
}

- (void)updateWithModel:(__kindof NSObject<VVTableVMProtocol> *)tableViewModel
{
    NSAssert([tableViewModel conformsToProtocol:@protocol(VVTableVMProtocol)], @"tableViewModel should conform VVTableVMProtocol");

	self.tableViewModel = tableViewModel;
    [self.tableView reloadData];
}

@end
