//
//  NSMutableArray+Protect.h
//  vv_rootlib_ios
//
//  Created by merlin on 2020/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (Protect)

/// 添加元素，当元素为nil时，测试环境会崩溃,线上环境不处理
- (void)vv_addObject:(ObjectType)anObject;

/// 插入元素，确保元素存在且下标正确，异常时，测试环境会崩溃,线上环境不处理
- (void)vv_insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

/// 移除元素，无元素时不操作，任何环境均不崩溃
- (void)vv_removeLastObject;

/// 移除元素，下标异常时，测试环境崩溃，线上环境不处理
- (void)vv_removeObjectAtIndex:(NSUInteger)index;

/// 替换元素，确保元素存在且下标正常，异常时，测试环境会崩溃,线上环境不处理
- (void)vv_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

/// 添加元素数组，确保类型正确，异常时，测试环境会崩溃,线上环境不处理
- (void)vv_addObjectsFromArray:(NSArray<ObjectType> *)otherArray;

/// 交换元素，确保下表正确，异常时，测试环境会崩溃,线上环境不处理
- (void)vv_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

/// 移除所有元素，无任何元素时不做处理
- (void)vv_removeAllObjects;

/// 移除元素，元素不存在时不操作
- (void)vv_removeObject:(ObjectType)anObject;

@end

NS_ASSUME_NONNULL_END
