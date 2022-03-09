//
//  KTBaseSectionModel.m
//  KOTU
//
//  Created by KOTU on 2019/12/19.
//

#import "KTBaseSectionModel.h"

@implementation KTBaseSectionModel

KTSynthesizeSectionModelProtocol

- (void)setDatas:(__kindof NSArray<id<KTReuseViewModelProtocol>> *)datas
{
	if (datas.count) {
		id <KTReuseViewModelProtocol> first = [datas firstObject];
		first.isFirstItem = YES;
		
		id <KTReuseViewModelProtocol> last = [datas lastObject];
		last.isLastItem = YES;
	}
	
	_datas = datas;
}

@end
