//
//  VVBaseCollectionDecorationView.m
//  vv_bodylib_ios
//
//  Created by KOTU on 2020/11/10.
//

#import "VVBaseCollectionDecorationView.h"
#import "VVBaseDecorationViewLayoutAttributes.h"
#import "VVBaseDecorationModel.h"
#import <Masonry/Masonry.h>

@interface VVBaseCollectionDecorationView ()

@end

@implementation VVBaseCollectionDecorationView

+ (NSString *)kind
{
    return [NSString stringWithFormat:@"%@_kind",NSStringFromClass(self)];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
#warning TODO
//    VVAssertReturnVoid([layoutAttributes isKindOfClass:VVBaseDecorationViewLayoutAttributes.class], @"类型错误");
    
    VVBaseDecorationViewLayoutAttributes *baseDecorationlayoutAttributes = (VVBaseDecorationViewLayoutAttributes *)layoutAttributes;
    
    VVBaseDecorationModel *decorationModel = baseDecorationlayoutAttributes.decorationModel;
    
    self.backgroundColor = decorationModel.backgroundColor;
    
    self.layer.cornerRadius = decorationModel.cornerRadius;
}

@end
