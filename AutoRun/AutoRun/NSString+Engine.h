//
//  NSString+Engine.h
//  WangweiTool
//
//  Created by Wangwei on 15/3/26.
//  Copyright (c) 2015年 Tool.Wangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Engine)


#pragma mark 计算字符串的大小

- (CGSize)string_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGSize)string_sizeWithFont:(UIFont *)font forHeight:(CGFloat)height;
- (CGFloat)string_heightWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGFloat)string_widthWithFont:(UIFont *)font forHeight:(CGFloat)height;

// 计算字符串的宽度
-(CGFloat)stringOfwidth:(CGFloat)font;
// 计算字符串的宽度WithFont
-(CGFloat)stringOfwidthWithFont:(UIFont *)font;
// 计算字符串粗体的宽度
-(CGFloat)stringBoldOfwidth:(CGFloat)font;
// 根据宽度计算字符串的高度
-(CGFloat)stringForWidth:(CGFloat)width with:(CGFloat)font;
// 根据宽度计算字符串粗体的高度
-(CGFloat)stringBoldForWidth:(CGFloat)width with:(CGFloat)font;
// 根据高度计算字符串的宽度
-(CGFloat)stringForHeight:(CGFloat)height with:(CGFloat)font;
// 根据高度计算粗体字符串的宽度
-(CGFloat)stringBoldForHeight:(CGFloat)height with:(CGFloat)font;

//根据时间戳 今天 昨天 前天  几天前
- (NSString *)dateFormatterTime;

#pragma mark  转换大小写
// 全部大写
- (NSString * )stringUpperCase;
// 全部小写
- (NSString * )stringLowerCase;
// 首字母大写
- (NSString * )stringFirstUpperCase;

#pragma mark 替换 删除 去空格 

// 替换
- (NSString * )stringWithOldString:(NSString *)oldString WithNewString:(NSString *)newString;
// 删除
- (NSString *)stringDeleteString:(NSString *)deleteString;
// 去空格
- (NSString *)stringDeleteSpace;

#pragma mark 分割 截取
// 截取前面
- (NSString *)stringToIndex:(NSInteger)index;
// 截取后面
- (NSString *)stringFromIndex:(NSInteger)index;
// 分割成数组
- (NSArray *)stringComponentsSeparateWithString:(NSString *)compString;
// 字符串转字典
-(NSDictionary *)parseJSONStringToNSDictionary;
// 从count位显示...
//-(NSString *)stringAtIndexByCount:(NSInteger)count;
- (NSString *)hideReplacementCenterNumberFromMobileNumberWithSubIndex:(NSUInteger)subIndex;
#pragma mark ************************各种转换************************

#pragma mark 16进制的字符串转16位Data
// 16进制 ,蓝牙常用到
- (NSData *)stringHexToBytesData;
// 10进制数转成16
- (NSString *)stringWithHexValueIntString:(NSString *)number;
// 16进制数转成10
- (NSInteger)stringWithIntValueHexString:(NSString *)numString;
// 10进制数转成16进制0xffff
- (NSString *)stringWithHexValueIntFormat:(NSString *)number;

// 字典转成字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic;
// 时间格式转换
- (NSString *)newTimeStringFormtter:(NSString * )newFormtter WithOldFormtter:(NSString *)oldFormetter;
//日期格式转换(yyyy.MM.dd 类型转为 YYYY-MM-dd HH:mm:ss 类型)
-(NSString *)convertToDateString;
// 根据时间戳类型计算距离当前日期
- (NSString *)intervalSinceNow;
//日期叠加
- (NSString *)dateStringAfterlocalDateForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second;
// 日期近多少天
+ (NSString *)dateWithOldDay:(int)index WithDate:(NSDate *)date;
+ (NSDate *)dateWithOldDaydate:(int)index WithDate:(NSDate *)date;
//日期近多少月
+ (NSString *)dateWithOldMonth:(int)index;
// 比较两个时间大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
//精度问题
+ (NSString *)decimalNumberWithDouble:(double)doubleValue;
// 拿到一个月最小天和最大天
+ (NSArray *)dateMinDayAndMaxDayWithDate:(NSString *)date;
// 计算两个日期的天数
+ (NSInteger)compareDayDate:(NSString*)startDate withDate:(NSString*)endDate;
@end
