//
//  KTCollectionViewCell2.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionViewCell2.h"
#import <Masonry/Masonry.h>
#import "KTBaseViewModel.h"

@interface KTCollectionViewCell2 ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation KTCollectionViewCell2

+ (CGSize)itemSizeWithModel:(id<KTReuseViewModelProtocol>)model
{
	return [(KTBaseViewModel *)model viewSize];
}

- (void)kt_setUpUI
{
	[self.contentView addSubview:self.titleLabel];
}

- (void)kt_setUpConstraints
{
	[self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.leading.mas_equalTo(10);
		make.top.mas_equalTo(10);
		make.trailing.mas_equalTo(-10);
		make.bottom.mas_offset(-10);
	}];
}

- (void)updateWithModel:(id <KTReuseViewModelProtocol>)model
{
	self.titleLabel.backgroundColor = [UIColor greenColor];

	if (model) {
		self.titleLabel.text = NSStringFromClass([model class]);
	} else {
		self.titleLabel.text = @"no model";
	}
}

#pragma mark - getter
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.font = [UIFont systemFontOfSize:16];
		_titleLabel.numberOfLines = 0;
		_titleLabel.backgroundColor = [UIColor blueColor];
	}
	return _titleLabel;
}

@end
