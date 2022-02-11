//
//  KTCollectionViewCell.m
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/10.
//  Copyright © 2022 KOTU. All rights reserved.
//

#import "KTCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface KTCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation KTCollectionViewCell

+ (CGSize)itemSizeWithModel:(id)model
{
	return CGSizeMake(100, 80);
}

- (void)setUpUI
{
	[self.contentView addSubview:self.titleLabel];
}

- (void)setUpConstraints
{
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.mas_equalTo(10);
		make.top.mas_equalTo(10);
		make.trailing.mas_equalTo(-10);
		make.bottom.mas_offset(-10);
	}];
}

- (void)updateWithModel:(id <VVReuseViewModelProtocol>)model
{
	self.titleLabel.backgroundColor = [UIColor redColor];
	
	if (model) {
		self.titleLabel.text = NSStringFromClass([model class]);
	} else {
		self.titleLabel.text = @"no model";
	}
}

#pragma mark - - getter - -
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
