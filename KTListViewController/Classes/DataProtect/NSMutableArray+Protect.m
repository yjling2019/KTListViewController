//
//  NSMutableArray+Protect.m
//  vv_rootlib_ios
//
//  Created by merlin on 2020/5/18.
//

#import "NSMutableArray+Protect.h"

@implementation NSMutableArray (Protect)

- (void)vv_addObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
#endif
    
    if (!anObject) {
        return;
    }
    
    [self addObject:anObject];
}

- (void)vv_insertObject:(id)anObject atIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index <= self.count, @"make sure index <= self.count be YES");
#endif
    
    if (!anObject) {
        return;
    }
    
    if (index > self.count) {
        return;
    }
    
    [self insertObject:anObject atIndex:index];
}

- (void)vv_removeLastObject
{
    if (self.count < 1) {
        return;
    }
    
    [self removeLastObject];
}

- (void)vv_removeObjectAtIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    
    if (index >= self.count) {
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)vv_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    
    if (!anObject) {
        return;
    }
    
    if (index >= self.count) {
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)vv_addObjectsFromArray:(NSArray *)otherArray
{
    BOOL isClassCorrect = [otherArray isKindOfClass:[NSArray class]];
    
#if DEBUG
    NSAssert(isClassCorrect, @"make sure otherArray is kind of class array");
#endif
    
    if (!isClassCorrect) {
        return;
    }
    
    if (otherArray.count < 1) {
        return;
    }
    
    [self addObjectsFromArray:otherArray];
}

- (void)vv_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
#if DEBUG
    NSAssert(idx1 < self.count, @"make sure idx1 < self.count");
    NSAssert(idx2 < self.count, @"make sure idx2 < self.count");
#endif
    
    if (idx1 >= self.count) {
        return;
    }
    
    if (idx2 >= self.count) {
        return;
    }
    
    [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)vv_removeAllObjects
{
    if (self.count < 1) {
        return;
    }
    
    [self removeAllObjects];
}

- (void)vv_removeObject:(id)anObject
{
    if (!anObject) {
        return;
    }
        
    [self removeObject:anObject];
}

@end
