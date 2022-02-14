//
//  KTListViewContainerProtocol.h
//  VVCommonKit
//
//  Created by KOTU on 2019/9/19.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#ifndef KTListViewContainerProtocol_h
#define KTListViewContainerProtocol_h

#import "KTListVMProtocol.h"
#import "KTCollectionVMProtocol.h"
#import "KTTableVMProtocol.h"

@protocol KTTableViewContainerProtocol<NSObject>

@required
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) __kindof id <KTTableVMProtocol> tableViewModel;

@optional
- (void)preloadListView:(UITableView *)listView atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectItem:(id <KTReuseViewModelProtocol>)item;

@end

@protocol KTCollectionViewContainerProtocol<NSObject>

@required
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) __kindof id <KTCollectionVMProtocol> collectionViewModel;

@optional
- (void)preloadListView:(UICollectionView *)listView atIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didSelectItem:(id <KTReuseViewModelProtocol>)item;

@end

#endif /* KTListViewContainerProtocol_h */
