//
//  NSDictionary+DataProtect.m
//  VVRootLib
//
//  Created by KOTU on 2019/8/14.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import "NSDictionary+DataProtect.h"

@implementation NSDictionary (DataProtect)

- (BOOL)vv_hasKey:(nonnull NSString *)key
{
    if (!key) {
        return NO;
    }
    return [self objectForKey:key] != nil;
}

- (nullable id)vv_objectForKey:(nonnull NSString *)key
                   verifyClass:(nullable Class)theClass
{
    id object = [self objectForKey:key];
    if (!theClass) {
        return object;
    }

    if (![theClass isSubclassOfClass:[NSObject class]]) {
#if DEBUG
        NSAssert(NO, @"theClass must be subClass of NSObject");
#endif
        return nil;
    }
        
    if ([object isKindOfClass:theClass]) {
        return object;
    }
    return nil;
}

- (nullable NSString *)vv_stringForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (nullable NSNumber *)vv_numberForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (nullable NSDecimalNumber *)vv_decimalNumberForKey:(nonnull NSString *)key
{
    
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (nullable NSArray*)vv_arrayForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }

    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (nullable NSDictionary*)vv_dictionaryForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)vv_integerForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)vv_unsignedIntegerForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)vv_boolForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)vv_int16ForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)vv_int32ForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)vv_int64ForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)vv_charForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)vv_shortForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)vv_floatForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (CGFloat)vv_cgFloatForKey:(nonnull NSString *)key
{
    CGFloat value = (CGFloat)[self vv_floatForKey:key];
    return value;
}

- (double)vv_doubleForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (long long)vv_longLongForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)vv_unsignedLongLongForKey:(nonnull NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        NSNumber *num = [nf numberFromString:value];
        return  [num unsignedLongLongValue];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (nullable NSDate *)vv_dateForKey:(nonnull NSString *)key
                        dateFormat:(nonnull NSString *)dateFormat
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = dateFormat;
        return [formater dateFromString:value];
    }
    return nil;
}

- (CGPoint)vv_pointForKey:(nonnull NSString *)key
{
    CGPoint point = CGPointFromString([self vv_stringForKey:key]);
    return point;
}

- (CGSize)vv_sizeForKey:(nonnull NSString *)key
{
    CGSize size = CGSizeFromString([self vv_stringForKey:key]);
    return size;
}

- (CGRect)vv_rectForKey:(nonnull NSString *)key
{
    CGRect rect = CGRectFromString([self vv_stringForKey:key]);
    return rect;
}

-  (nullable NSDictionary *)vv_dictionaryForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        dic = [dic vv_dictionaryForKey:key];
        if (!dic) {
            break;
        }
    }
    
    return dic;
}

- (nullable NSArray *)vv_arrayForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    NSArray *array = nil;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          array = [dic vv_arrayForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return array;
}

- (nullable NSString *)vv_stringForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    NSString *string = nil;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          string = [dic vv_stringForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return string;
}

- (nullable NSNumber *)vv_numberForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    NSNumber *number = nil;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          number = [dic vv_numberForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return number;
}

- (NSInteger)vv_integerForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    NSInteger value = 0;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          value = [dic vv_integerForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return value;
}

- (CGFloat)vv_cgFloatForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    CGFloat value = 0;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          value = [dic vv_cgFloatForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return value;
}

- (float)vv_floatForKeyPath:(nonnull NSString *)keyPath
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSDictionary *dic = self;
    float value = 0;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if (i == keys.count - 1) {
          value = [dic vv_floatForKey:key];
            if (!dic) {
                break;
            }
        } else {
          dic = [dic vv_dictionaryForKey:key];
            if (!dic) {
                break;
            }
        }
    }
    
    return value;
}

- (double)vv_doubleForKeyPath:(nonnull NSString *)keyPath
{
   NSArray *keys = [keyPath componentsSeparatedByString:@"."];
   NSDictionary *dic = self;
   double value = 0;
   
   for (NSInteger i = 0; i < keys.count; i++) {
       NSString *key = keys[i];
       if (i == keys.count - 1) {
         value = [dic vv_doubleForKey:key];
           if (!dic) {
               break;
           }
       } else {
         dic = [dic vv_dictionaryForKey:key];
           if (!dic) {
               break;
           }
       }
   }
   
   return value;
}

- (BOOL)vv_boolForKeyPath:(nonnull NSString *)keyPath
{
  NSArray *keys = [keyPath componentsSeparatedByString:@"."];
  NSDictionary *dic = self;
  BOOL value = NO;
  
  for (NSInteger i = 0; i < keys.count; i++) {
      NSString *key = keys[i];
      if (i == keys.count - 1) {
        value = [dic vv_boolForKey:key];
          if (!dic) {
              break;
          }
      } else {
        dic = [dic vv_dictionaryForKey:key];
          if (!dic) {
              break;
          }
      }
  }
  
  return value;
}

@end
