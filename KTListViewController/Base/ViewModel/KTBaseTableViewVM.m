//
//  KTBaseTableViewVM.m
//  KOTU
//
//  Created by KOTU on 2019/8/19.
//  Copyright © 2019 KOTU. All rights reserved.
//

#import "KTBaseTableViewVM.h"
#import <UIKit/UIKit.h>
#import <KTFoundation/NSArray+KTHelp.h>

@implementation KTBaseTableViewVM

KTSynthesizeTableVMProtocol
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

- (NSInteger)rowCountWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return 0;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector datas");
		return 0;
	}
	
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector datas");
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
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector datas");
		return 0;
	}
	
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector datas");
		return 0;
	}
	
	return [[sectionObject datas] kt_objectAtIndex:indexPath.row];
}

- (id)modelOfReuseViewHeaderViewWithSection:(NSInteger)section
{
	id sectionObject = [self.datas kt_objectAtIndex:section];
	if (!sectionObject) {
		return nil;
	}
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector headerModel");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(headerModel)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector headerModel");
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
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector footerModel");
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(footerModel)]) {
		NSAssert(NO, @"sectionObject must conform protocol KTSectionModelProtocol and respond selector footerModel");
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
		return nil;
	}
		
	if (![sectionObject respondsToSelector:@selector(datas)]) {
		return nil;
	}
		
	NSArray *datas = [sectionObject datas];
	id object = [datas kt_objectAtIndex:indexPath.row];
	
	if (![object conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		return nil;
	}
	
	if (![object respondsToSelector:@selector(reuseViewClassName)]) {
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
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(headerModel)]) {
		return nil;
	}
	
	id headerModel = [sectionObject headerModel];

	if (![headerModel conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		return nil;
	}
                
	if (![headerModel respondsToSelector:@selector(reuseViewClassName)]) {
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
	
	if (![sectionObject conformsToProtocol:@protocol(KTSectionModelProtocol)]){
		return nil;
	}
	
	if (![sectionObject respondsToSelector:@selector(footerModel)]) {
		return nil;
	}
	
		id footerModel = [sectionObject footerModel];
		if (!footerModel) {
			return nil;
		}
	
	if (![footerModel conformsToProtocol:@protocol(KTReuseViewModelProtocol)]) {
		return nil;
	}
	
	if (![footerModel respondsToSelector:@selector(reuseViewClassName)]) {
		return nil;
	}
		
	return [footerModel reuseViewClassName];
}

@end
