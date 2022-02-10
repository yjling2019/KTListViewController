//
//  NSDictionary+DataProtect.h
//  VVRootLib
//
//  Created by JackLee on 2019/8/14.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>
#import <CoreGraphics/CGBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (DataProtect)

- (BOOL)vv_hasKey:(NSString *)key;

/// 根据key获取元素值，并对元素类型进行判断
/// @param key key
/// @param theClass 进行判定的类
- (nullable ObjectType)vv_objectForKey:(nonnull NSString *)key
                   verifyClass:(nullable Class)theClass;

/**
 根据key解析，结果如果是字符串的直接返回，如果是NSNumber类型的会转换为NSString类型

 @param key key
 @return string对象
 */
- (nullable NSString *)vv_stringForKey:(nonnull NSString *)key;

/**
 根据key解析，结果如果是NSNumber的直接返回，如果是NSString类型的会转换为NSNumber类型
 
 @param key key
 @return NSNumber对象
 */
- (nullable NSNumber *)vv_numberForKey:(nonnull NSString *)key;

- (nullable NSDecimalNumber *)vv_decimalNumberForKey:(nonnull NSString *)key;

- (nullable NSArray *)vv_arrayForKey:(nonnull NSString *)key;

- (nullable NSDictionary *)vv_dictionaryForKey:(nonnull NSString *)key;

- (NSInteger)vv_integerForKey:(nonnull NSString *)key;

- (NSUInteger)vv_unsignedIntegerForKey:(nonnull NSString *)key;

- (BOOL)vv_boolForKey:(nonnull NSString *)key;

- (int16_t)vv_int16ForKey:(nonnull NSString *)key;

- (int32_t)vv_int32ForKey:(nonnull NSString *)key;

- (int64_t)vv_int64ForKey:(nonnull NSString *)key;

- (char)vv_charForKey:(nonnull NSString *)key;

- (short)vv_shortForKey:(nonnull NSString *)key;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param key key
- (float)vv_floatForKey:(nonnull NSString *)key;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param key key
- (CGFloat)vv_cgFloatForKey:(nonnull NSString *)key;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param key key
- (double)vv_doubleForKey:(nonnull NSString *)key;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param key key
- (long long)vv_longLongForKey:(nonnull NSString *)key;

- (unsigned long long)vv_unsignedLongLongForKey:(nonnull NSString *)key;

- (nullable NSDate *)vv_dateForKey:(nonnull NSString *)key
                        dateFormat:(nonnull NSString *)dateFormat;

- (CGPoint)vv_pointForKey:(nonnull NSString *)key;

- (CGSize)vv_sizeForKey:(nonnull NSString *)key;

- (CGRect)vv_rectForKey:(nonnull NSString *)key;

-  (nullable NSDictionary *)vv_dictionaryForKeyPath:(nonnull NSString *)keyPath;

- (nullable NSArray *)vv_arrayForKeyPath:(nonnull NSString *)keyPath;

- (nullable NSString *)vv_stringForKeyPath:(nonnull NSString *)keyPath;

- (nullable NSNumber *)vv_numberForKeyPath:(nonnull NSString *)keyPath;

- (NSInteger)vv_integerForKeyPath:(nonnull NSString *)keyPath;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param keyPath keyPath
- (CGFloat)vv_cgFloatForKeyPath:(nonnull NSString *)keyPath;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param keyPath keyPath
- (float)vv_floatForKeyPath:(nonnull NSString *)keyPath;

/// 存在精度问题，可以通过限定位数，NSDecimalNumber 实现更高的精度
/// @param keyPath keyPath
- (double)vv_doubleForKeyPath:(nonnull NSString *)keyPath;

- (BOOL)vv_boolForKeyPath:(nonnull NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
