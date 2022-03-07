//
//  KTBaseCollectionDecorationView.m
//  KOTU
//
//  Created by KOTU on 2020/11/10.
//

#import "KTBaseCollectionDecorationView.h"
#import "KTBaseDecorationViewLayoutAttributes.h"
#import "KTBaseDecorationModel.h"
#import <Masonry/Masonry.h>

@interface KTBaseCollectionDecorationView ()

@end

@implementation KTBaseCollectionDecorationView

+ (NSString *)kind
{
    return [NSString stringWithFormat:@"%@_kind",NSStringFromClass(self)];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSAssert([layoutAttributes isKindOfClass:KTBaseDecorationViewLayoutAttributes.class], @"类型错误");
    
    KTBaseDecorationViewLayoutAttributes *baseDecorationlayoutAttributes = (KTBaseDecorationViewLayoutAttributes *)layoutAttributes;
    
    KTBaseDecorationModel *decorationModel = baseDecorationlayoutAttributes.decorationModel;
    
    self.backgroundColor = decorationModel.backgroundColor;
    self.layer.cornerRadius = decorationModel.cornerRadius;
}

@end
