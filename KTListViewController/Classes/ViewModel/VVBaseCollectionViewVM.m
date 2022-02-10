//
//  VVBaseCollectionViewVM.m
//  MVVMDemo
//
//  Created by JackLee on 2019/8/19.
//  Copyright © 2019 JackLee. All rights reserved.
//

#import "VVBaseCollectionViewVM.h"
#import <UIKit/UIKit.h>
#import "VVDataHelper.h"
#import "VVModelProtocol.h"

@interface VVBaseCollectionVMConfig()

@property (nonatomic, assign, readwrite) BOOL isMultiCell;

@end

@implementation VVBaseCollectionVMConfig

KTSynthesizeCollectionVMConfigProtocol

#pragma mark - - getter - -
- (BOOL)isMultiCell
{
    return !(self.cellClassName.length > 0);
}

@end

@implementation VVBaseCollectionViewVM

KTSynthesizeCollectionVMProtocol
KTSynthesizeListVMProtocol

#pragma mark - public
- (nullable NSIndexPath *)indexPathOfViewModel:(id)vm
{
	if (!vm) {
		return nil;
	}
	
	NSIndexPath *indexPath;
	
	if (self.config.isMultiSection) {
		for (VVBaseCollectionViewVM *sectionVM in self.datas) {
			NSInteger item = [sectionVM.datas indexOfObject:vm];
			if (item == NSNotFound) {
				continue;
			}
			
			NSInteger section = [self.datas indexOfObject:sectionVM];
			if (section == NSNotFound) {
				NSAssert(NO, @"VVBaseCollectionViewVM: section not found, maybe self.datas changed");
				continue;
			}
				
			indexPath = [NSIndexPath indexPathForItem:item inSection:section];
			break;
		}
	} else {
		NSInteger item = [self.datas indexOfObject:vm];
		if (item != NSNotFound) {
			indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		}
	}
	
	return indexPath;
}

#pragma mark -
- (NSInteger)sectionCount
{
    if (self.config.isMultiSection) {
        return self.datas.count;
    }
    return 1;
}

- (NSInteger)itemCountWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return 0;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(datas)]) {
            return [sectionObject datas].count;
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector datas");
#endif
            return 0;
        }
    }
    return self.datas.count;
}

- (id)modelWithIndexPath:(NSIndexPath *)indexPath{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:indexPath.section];
        if (!sectionObject) {
            return nil;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(datas)]) {
            return [[sectionObject datas] vv_objectWithIndex:indexPath.item];
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector datas");
#endif
            return nil;
        }
    }
    return [self.datas vv_objectWithIndex:indexPath.item];
}

- (CGFloat)itemMinLineSpacingWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id<VVSectionModelProtocol> sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            // 兼容老版本，只能返回self.config.lineSpace，不能有assert
            return self.config.lineSpace;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(minimumLineSpacing)]) {
            return [sectionObject minimumLineSpacing];
        } else {
            // 兼容老版本，只能返回self.config.lineSpace，不能有assert
            return self.config.lineSpace;
        }
    }
    return self.config.lineSpace;
}

- (CGFloat)itemMinInterSpacingWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id<VVSectionModelProtocol> sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            // 兼容老版本，只能返回self.config.interSpace，不能有assert
            return self.config.interSpace;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(minimumInteritemSpacing)]) {
            return [sectionObject minimumInteritemSpacing];
        } else {
            // 兼容老版本，只能返回self.config.interSpace，不能有assert
            return self.config.interSpace;
        }
    }
    return self.config.interSpace;
}

- (UIEdgeInsets)sectionInsetsWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id<VVSectionModelProtocol> sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            // 兼容老版本，只能返回self.config.sectionInsets
            return self.config.sectionInsets;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(sectionInsets)]) {
            return [sectionObject sectionInsets];
        } else {
            // 兼容老版本，只能返回self.config.sectionInsets，不能有assert
            return self.config.sectionInsets;
        }
    }
    return self.config.sectionInsets;
}

- (NSInteger)sectionColumnNumberWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return 1;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(columnNumber)]) {
            return [sectionObject columnNumber];
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector headerModel");
#endif
            return 1;
        }
    }
    return self.config.columnNumber;
}

- (id)modelOfReuseViewHeaderViewWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return nil;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(headerModel)]) {
            return [sectionObject headerModel];
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector headerModel");
#endif
            return nil;
        }
    }
    return self.config.headerModel;
}

- (id)modelOfReuseViewFooterViewWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return nil;
        }
         if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
             && [sectionObject respondsToSelector:@selector(footerModel)]) {
             return [sectionObject footerModel];
         } else {
 #if DEBUG
             NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector footerModel");
 #endif
             return nil;
         }
    }
    return self.config.footerModel;
}

- (NSString *)reuseViewClassNameWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.config.isMultiSection) {
        if (self.config.isMultiCell) {
            id sectionObject = [self.datas vv_objectWithIndex:indexPath.section];
            if (!sectionObject) {
                return nil;
            }
            if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
                && [sectionObject respondsToSelector:@selector(datas)]) {
                NSArray *datas = [sectionObject datas];
                id object = [datas vv_objectWithIndex:indexPath.item];
                if (!object) {
                    return nil;
                }
                if ([object conformsToProtocol:@protocol(VVReuseViewModelProtocol)]
                    && [object respondsToSelector:@selector(reuseViewClassName)]) {
                    return [object reuseViewClassName];
                } else {
#if DEBUG
                   NSAssert(NO, @"object must conform protocol VVReuseViewModelProtocol and respond selector reuseViewClassName");
#endif
                   return nil;
                }
            } else {
#if DEBUG
                NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector datas");
#endif
                return nil;
            }
        }
    } else {
        if (self.config.isMultiCell) {
            id object = [self.datas vv_objectWithIndex:indexPath.item];
            if (!object) {
                return nil;
            }
            if ([object conformsToProtocol:@protocol(VVReuseViewModelProtocol)]
                && [object respondsToSelector:@selector(reuseViewClassName)]) {
                return [object reuseViewClassName];
            } else {
#if DEBUG
               NSAssert(NO, @"object must conform protocol VVReuseViewModelProtocol and respond selector reuseViewClassName");
#endif
               return nil;
            }
        }
    }
    return self.config.cellClassName;
}

- (NSString *)reuseViewHeaderViewClassNameWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
      id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return nil;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(headerModel)]) {
            id headerModel = [sectionObject headerModel];
            if (!headerModel) {
                return nil;
            }
            if ([headerModel conformsToProtocol:@protocol(VVReuseViewModelProtocol)]
                && [headerModel respondsToSelector:@selector(reuseViewClassName)]) {
                return [headerModel reuseViewClassName];
            } else {
#if DEBUG
               NSAssert(NO, @"headerModel must conform protocol VVReuseViewModelProtocol and respond selector reuseViewClassName");
#endif
               return nil;
            }
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector headerModel");
#endif
            return nil;
        }
    }
    return self.config.headerClassName;
}

- (NSString *)reuseViewFooterViewClassNameWithSection:(NSInteger)section
{
    if (self.config.isMultiSection) {
        id sectionObject = [self.datas vv_objectWithIndex:section];
        if (!sectionObject) {
            return nil;
        }
        if ([sectionObject conformsToProtocol:@protocol(VVSectionModelProtocol)]
            && [sectionObject respondsToSelector:@selector(footerModel)]) {
            id footerModel = [sectionObject footerModel];
            if (!footerModel) {
                return nil;
            }
            if ([footerModel conformsToProtocol:@protocol(VVReuseViewModelProtocol)]
                && [footerModel respondsToSelector:@selector(reuseViewClassName)]) {
                return [footerModel reuseViewClassName];
            } else {
#if DEBUG
               NSAssert(NO, @"footerModel must conform protocol VVReuseViewModelProtocol and respond selector reuseViewClassName");
#endif
               return nil;
            }
        } else {
#if DEBUG
            NSAssert(NO, @"sectionObject must conform protocol VVSectionModelProtocol and respond selector footerModel");
#endif
            return nil;
        }
    }
    return self.config.footerClassName;
}

#pragma mark - getter -
- (id<VVCollectionVMConfigProtocol>)config
{
    if (!_config) {
        _config = [VVBaseCollectionVMConfig new];
        _config.lineSpace = 0;
        _config.interSpace = 0;
        _config.sectionInsets = UIEdgeInsetsZero;
        _config.columnNumber = 1;
    }
    return _config;
}

@end
