//
//  KTTextListView.m
//  KTFoundation
//
//  Created by KOTU on 2022/8/3.
//

#import "KTTextListView.h"
#import "KTTextListViewVM.h"
#import "KTTextListCellVM.h"
#import "KTBaseSectionModel.h"
#import <KTFoundation/NSString+KTHelp.h>
#import <Masonry/Masonry.h>

@interface KTTextListView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) KTTextListViewVM *collectionViewModel;

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSArray <NSString *> *texts;
@property (nonatomic, strong) NSMutableDictionary *fonts;

@end

@implementation KTTextListView

@synthesize collectionViewModel = _collectionViewModel;

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self kt_setUpUI];
		[self kt_setUpConstraints];
	}
	return self;
}

- (void)kt_setUpUI
{
	self.collectionView.showsHorizontalScrollIndicator = NO;
	[self addSubview:self.collectionView];
}

- (void)kt_setUpConstraints
{
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.leading.trailing.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.bottom.mas_equalTo(0);
	}];
}

- (void)registerItemClass:(NSString *)className
{
	Class cellClass = NSClassFromString(className);
	
	if (!cellClass) {
		return;
	}
	
	self.className = className;
	if ([cellClass conformsToProtocol:@protocol(KTCollectionCellProtocol)]
		&& [cellClass respondsToSelector:@selector(identifier)]) {
		[self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass identifier]];
	}
}

- (void)updateTextList:(NSArray <NSString *> *)texts
{
	self.texts = texts;
}

- (void)setFont:(UIFont *)font forState:(UIControlState)state
{
	[self.fonts setObject:font forKey:@(state)];
}

- (void)updateItemState:(UIControlState)state atIndex:(NSInteger)index
{
	if (index >= self.texts.count) {
		return;
	}
	
	KTBaseSectionModel *sm = self.collectionViewModel.datas.firstObject;
	if (index >= sm.datas.count) {
		return;
	}
	
	KTTextListCellVM *vm = [sm.datas objectAtIndex:index];
	vm.state = state;
	[self.collectionView reloadData];
}

- (void)kt_forceRefreshUI
{
	NSAssert(self.className, @"you should register item class first");
	
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.sectionInsets.top);
		make.bottom.mas_equalTo(self.sectionInsets.bottom * -1);
	}];
	
	NSMutableArray *datas = [NSMutableArray array];
	
	for (NSString *text in self.texts) {
		KTTextListCellVM *vm = [KTTextListCellVM new];
		vm.rawData = text;
		vm.reuseViewClassName = self.className;
		
		[datas addObject:vm];
	}
	
	KTBaseSectionModel *sm = [KTBaseSectionModel new];
	sm.datas = datas.copy;
	sm.minimumLineSpacing = self.itemSpace;
	sm.minimumInteritemSpacing = self.itemSpace;
	sm.sectionInsets = UIEdgeInsetsMake(0, self.sectionInsets.left, 0, self.sectionInsets.right);
	
	self.collectionViewModel.datas = @[sm];
	[self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(textListView:didSelectItemAtIndex:)]) {
		[self.delegate textListView:self didSelectItemAtIndex:indexPath.item];
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	KTBaseSectionModel *sm = [self.collectionViewModel.datas objectAtIndex:indexPath.section];
	KTTextListCellVM *vm = [sm.datas objectAtIndex:indexPath.row];
	
	NSNumber *num = [vm.widthCache objectForKey:@(vm.state)];
	if (num) {
		CGSize size = CGSizeMake(num.floatValue, self.frame.size.height - self.sectionInsets.top - self.sectionInsets.bottom);
		return size;
	}
	
	UIFont *font = [self.fonts objectForKey:@(vm.state)];
	if (!font) {
		font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
	}
	
	CGFloat width;
	if (!vm.rawData || ![vm.rawData isKindOfClass:[NSString class]]) {
		width = self.itemExtraWidth;
	} else {
		width = [((NSString *)vm.rawData) kt_widthForFont:font] + self.itemExtraWidth;
	}
	
	if (self.itemMinWidth) {
		width = MAX(width, self.itemMinWidth.floatValue);
	}
	
	if (self.itemMaxWidth) {
		width = MIN(width, self.itemMaxWidth.floatValue);
	}
	
	[vm.widthCache setObject:@(width) forKey:@(vm.state)];
	
	CGSize size = CGSizeMake(width, self.frame.size.height - self.sectionInsets.top - self.sectionInsets.bottom);
	return size;
}

#pragma mark - lazy load
- (KTTextListViewVM *)collectionViewModel
{
	if (!_collectionViewModel) {
		_collectionViewModel = [[KTTextListViewVM alloc] init];
	}
	return _collectionViewModel;
}

- (UICollectionViewLayout *)collectionViewLayout
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	return layout;
}

- (NSMutableDictionary *)fonts
{
	if (!_fonts) {
		_fonts = [NSMutableDictionary dictionary];
	}
	return _fonts;
}

@end
