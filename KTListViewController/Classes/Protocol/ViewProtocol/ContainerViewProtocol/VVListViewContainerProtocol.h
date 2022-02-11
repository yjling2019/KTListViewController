//
//  VVListViewContainerProtocol.h
//  VVCommonKit
//
//  Created by KOTU on 2019/9/19.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#ifndef VVListViewContainerProtocol_h
#define VVListViewContainerProtocol_h

#import "VVListVMProtocol.h"
#import "VVCollectionVMProtocol.h"
#import "VVTableVMProtocol.h"

@protocol VVTableViewContainerProtocol<NSObject>

@required
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) __kindof id <VVTableVMProtocol> tableViewModel;

@optional
- (void)tableView:(UITableView *)tableView didSelectItem:(id <VVReuseViewModelProtocol>)item;

@end

@protocol VVCollectionViewContainerProtocol<NSObject>

@required
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) __kindof id <VVCollectionVMProtocol> collectionViewModel;

@optional
- (void)preloadWithIndexPath:(NSIndexPath *)indexpath;
- (void)collectionView:(UIView *)collectionView didSelectItem:(id <VVReuseViewModelProtocol>)item;

@end

#endif /* VVListViewContainerProtocol_h */
