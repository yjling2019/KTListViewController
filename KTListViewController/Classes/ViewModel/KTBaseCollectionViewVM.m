//
//  KTBaseCollectionViewVM.m
//  KOTU
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseCollectionViewVM.h"
#import <UIKit/UIKit.h>
#import "KTModelProtocol.h"
#import <KTFoundation/NSArray+KTHelp.h>

@interface KTBaseCollectionVMConfig()

@end

@implementation KTBaseCollectionVMConfig

KTSynthesizeCollectionVMConfigProtocol
KTSynthesizeCollectionLayoutConfigProtocol

@end

@implementation KTBaseCollectionViewVM

KTSynthesizeCollectionVMProtocol
KTSynthesizeListVMProtocol

#pragma mark - public
- (nullable NSIndexPath *)indexPathOfViewModel:(id<KTReuseViewModelProtocol>)vm
{
	if (!vm) {
		return nil;
	}
	
	NSIndexPath *indexPath;
	
	for (id <KTSectionModelProtocol> sectionVM in self.datas) {
		NSInteger item = [sectionVM.datas indexOfObject:vm];
		if (item == NSNotFound) {
			continue;
		}
		
		NSInteger section = [self.datas indexOfObject:sectionVM];
		if (section == NSNotFound) {
			NSAssert(NO, @"KTBaseCollectionViewVM: section not found, maybe self.datas changed");
			continue;
		}
			
		indexPath = [NSIndexPath indexPathForItem:item inSection:section];
		break;
	}
	
	return indexPath;
}

#pragma mark - KTListVMProtocol
- (NSInteger)sectionCount
{
	return self.datas.count;
}

- (NSInteger)itemCountWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return 0;
	}

	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return 0;
	}
	
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		NSAssert(NO, @"sectionObject must respond selector datas");
		return 0;
	}
	
	return [sectionObject datas].count;
}

- (id)modelWithIndexPath:(NSIndexPath *)indexPath
{
	id sectionObject = [self.datas kt_objectAtIndex:indexPath.section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		return nil;
	}
	
	return [[sectionObject datas] kt_objectAtIndex:indexPath.item];
}

- (CGFloat)itemMinLineSpacingWithSection:(NSInteger)section
{
	id <KTSectionModelProtocol> sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return self.config.lineSpace;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		return self.config.lineSpace;
	}
	
	if (![sectionObject respondsToSelector:@selector(minimumLineSpacing)]) {
		return self.config.lineSpace;
	}
	
	return [sectionObject minimumLineSpacing];
}

- (CGFloat)itemMinInterSpacingWithSection:(NSInteger)section
{
	id <KTSectionModelProtocol> sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return self.config.interSpace;
	}

	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		return self.config.interSpace;
	}
	
	if (![sectionObject respondsToSelector:@selector(minimumInteritemSpacing)]) {
		return self.config.interSpace;
	}
	
	return [sectionObject minimumInteritemSpacing];
}

- (UIEdgeInsets)sectionInsetsWithSection:(NSInteger)section
{
	id <KTSectionModelProtocol> sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return self.config.sectionInsets;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		return self.config.sectionInsets;
	}
	
	if (![sectionObject respondsToSelector:@selector(sectionInsets)]) {
		return self.config.sectionInsets;
	}

	return [sectionObject sectionInsets];
}

- (NSInteger)sectionColumnNumberWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return 1;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		return 1;
	}
	
	if (![sectionObject respondsToSelector:@selector(columnNumber)]) {
		return 1;
	}

	return [sectionObject columnNumber];
}

- (id)modelOfReuseViewHeaderViewWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(headerModel)]) {
		NSAssert(NO, @"sectionObject must respond selector headerModel");
		return nil;
	}
	
	return [sectionObject headerModel];
}

- (id)modelOfReuseViewFooterViewWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(footerModel)]) {
		NSAssert(NO, @"sectionObject must respond selector footerModel");
		return nil;
	}
	
	return [sectionObject footerModel];
}

- (NSString *)reuseViewClassNameWithIndexPath:(NSIndexPath *)indexPath
{
	id sectionObject = [self.datas kt_objectAtIndex:indexPath.section];
	if (!sectionObject) {
		return nil;
	}
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		NSAssert(NO, @"sectionObject must respond selector datas");
		return nil;
	}
	
	NSArray *datas = [sectionObject datas];
	
	id object = [datas kt_objectAtIndex:indexPath.item];
	if (!object) {
		return nil;
	}
	
	if (![object conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		NSAssert(NO, @"object must conform protocol KTReuseViewModelProtocol");
		return nil;
	}
	
	if (![object respondsToSelector:@selector(reuseViewClassName)]) {
		NSAssert(NO, @"object must respond selector reuseViewClassName");
		return nil;
	}
	
	return [object reuseViewClassName];
}

- (NSString *)reuseViewHeaderViewClassNameWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(headerModel)]) {
		NSAssert(NO, @"sectionObject must respond selector headerModel");
		return nil;
	}
	
	id headerModel = [sectionObject headerModel];
	
	if (!headerModel) {
		return nil;
	}
	
	if (![headerModel conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		NSAssert(NO, @"headerModel must respond selector reuseViewClassName");
		return nil;
	}
	
	if (![headerModel respondsToSelector:@selector(reuseViewClassName)]) {
		NSAssert(NO, @"headerModel must respond selector reuseViewClassName");
		return nil;
	}

	return [headerModel reuseViewClassName];
}

- (NSString *)reuseViewFooterViewClassNameWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(footerModel)]) {
		NSAssert(NO, @"sectionObject must respond selector footerModel");
		return nil;
	}
	
	id footerModel = [sectionObject footerModel];
	if (!footerModel) {
		return nil;
	}
	
	if (![footerModel conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		NSAssert(NO, @"footerModel must conform protocol KTReuseViewModelProtocol");
		return nil;
	}
	
	if (![footerModel respondsToSelector:@selector(reuseViewClassName)]) {
		NSAssert(NO, @"footerModel must respond selector reuseViewClassName");
		return nil;
	}
			
	return [footerModel reuseViewClassName];
}

#pragma mark - getter -
- (id<KTCollectionVMConfigProtocol>)config
{
    if (!_config) {
        _config = [KTBaseCollectionVMConfig new];
        _config.lineSpace = 0;
        _config.interSpace = 0;
        _config.sectionInsets = UIEdgeInsetsZero;
        _config.columnNumber = 1;
    }
    return _config;
}

@end
