//
//  KTTableCell.m
//  KTListViewController_Example
//
//  Created by KOTU on 2021/12/10.
//  Copyright © 2021 KOTU. All rights reserved.
//

#import "KTTableCell.h"
#import <Masonry/Masonry.h>

@interface KTTableCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation KTTableCell

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 88;
}

- (void)kt_setUpUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
