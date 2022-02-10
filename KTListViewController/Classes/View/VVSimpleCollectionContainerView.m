//
//  VVSimpleCollectionContainerView.m
//  vv_bodylib_ios
//
//  Created by KOTU on 2021/5/18.
//

#import "VVSimpleCollectionContainerView.h"
#import <Masonry/Masonry.h>

@interface VVSimpleCollectionContainerView()

@property (nonatomic, strong) NSArray <Class>*simple_cellClasses;
@property (nonatomic, strong) NSArray <Class> *simple_reuseViewClasses;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, strong) __kindof id<VVCollectionVMProtocol> collectionViewModel;

@end

@implementation VVSimpleCollectionContainerView

@synthesize collectionViewModel;

+ (instancetype)initWithCellClasses:(NSArray <Class>*)cellClasses
                   reuseViewClasses:(nullable NSArray <Class>*)reuseViewClasses
                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                collectionViewModel:(__kindof NSObject<VVCollectionVMProtocol>*)collectionViewModel
{
    NSAssert(cellClasses.count > 0, @"make sure cellClasses.count > 0");

	VVSimpleCollectionContainerView *containerView = [[super alloc] init];
    containerView.simple_cellClasses = cellClasses;
    containerView.simple_reuseViewClasses = reuseViewClasses;
    containerView.collectionViewModel = collectionViewModel;
    containerView.scrollDirection = scrollDirection;
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

- (UICollectionViewLayout *)collectionViewLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = self.scrollDirection;
    return layout;
}

- (void)setUpUI
{
    [self addSubview:self.collectionView];
}

- (void)setUpConstraints
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
}

- (void)updateWithModel:(__kindof NSObject<VVCollectionVMProtocol>*)collectionViewModel
{
    NSAssert([collectionViewModel conformsToProtocol:@protocol(VVCollectionVMProtocol)], @"collectionViewModel should conform VVCollectionVMProtocol");

	self.collectionViewModel = collectionViewModel;
    [self.collectionView reloadData];
}

@end
