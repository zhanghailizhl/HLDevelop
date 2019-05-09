//
//  NSString+Engine.m
//  WangweiTool
//
//  Created by Wangwei on 15/3/26.
//  Copyright (c) 2015年 Tool.Wangwei. All rights reserved.
//

#import "NSString+Engine.h"

@implementation NSString (Engine)


- (CGSize)string_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width{
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil].size;
}
- (CGSize)string_sizeWithFont:(UIFont *)font forHeight:(CGFloat)height{
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font} context:nil].size;
}
- (CGFloat)string_heightWithFont:(UIFont *)font forWidth:(CGFloat)width{
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil].size.height;
}
- (CGFloat)string_widthWithFont:(UIFont *)font forHeight:(CGFloat)height{
     return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil].size.width;
}


#pragma mark 计算字符串的大小
// 计算字符串的宽度
-(CGFloat)stringOfwidth:(CGFloat)font{
    CGSize strSize = [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    return strSize.width;
}
// 计算字符串的宽度WithFont
-(CGFloat)stringOfwidthWithFont:(UIFont *)font{
    CGSize strSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    return strSize.width;
}
// 计算字符串粗体的宽度
-(CGFloat)stringBoldOfwidth:(CGFloat)font{
    CGSize strSize = [self sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]}];
    return strSize.width;
}
// 根据宽度计算字符串的高度
-(CGFloat)stringForWidth:(CGFloat)width with:(CGFloat)font{
     return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.height;
}
// 根据宽度计算字符串粗体的高度
-(CGFloat)stringBoldForWidth:(CGFloat)width with:(CGFloat)font{
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:font]} context:nil].size.height;
}
// 根据高度计算字符串的宽度
-(CGFloat)stringForHeight:(CGFloat)height with:(CGFloat)font{
     return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.width;
}
// 根据高度计算粗体字符串的宽度
-(CGFloat)stringBoldForHeight:(CGFloat)height with:(CGFloat)font{
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:font] } context:nil].size.width;
}

//根据时间戳 今天 昨天 前天  具体时间
- (NSString *)dateFormatterTime
{
    NSString *dateString;
    NSTimeInterval timeInterval = (NSTimeInterval)(self.longLongValue);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDate *today = [NSDate date];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *todayString = [dateFormatter stringFromDate:today];
    NSDate *today_start = [dateFormatter dateFromString:todayString];
    NSDate *oneSecond = [today_start dateByAddingTimeInterval:- 60];
    NSDate *oneMinute = [today_start dateByAddingTimeInterval:- (59 * 60)];
    NSDate *oneHours = [today_start dateByAddingTimeInterval:- (60 * 60)];
    NSDate *beforeToday = [today_start dateByAddingTimeInterval:-(23 * 60 * 60)];
    NSDate *yesterday_start = [today_start dateByAddingTimeInterval:-(24 * 60 * 60)];
    NSDate *yesterdayBefore_start = [today_start dateByAddingTimeInterval:-(24 * 60 * 60 * 2)];
    
    [dateFormatter setDateFormat:nil];
    if (date == [date laterDate:oneSecond])
    {
        dateString = @"一分钟前";
    }
    else if (date == [date laterDate:oneMinute])
    {
        dateString = @"59分钟前";
    }
    else if (date == [date laterDate:oneHours])
    {
        dateString = @"一小时前";
    }
    else if (date == [date laterDate:beforeToday])
    {
        dateString = @"23小时前";
    }
    else if (date == [date laterDate:yesterday_start])
    {
        dateString = @"昨天";
    }
    else if (date == [date laterDate:yesterdayBefore_start])
    {
        dateString = @"前天";
    }
    else
    {
        //显示时期
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        dateString = [dateFormatter stringFromDate:date];
    }
    return dateString;
}

#pragma mark  转换大小写
// 全部大写
- (NSString * )stringUpperCase{
   return  [self uppercaseString];
}
// 全部小写
- (NSString * )stringLowerCase{
    return [self lowercaseString];
}
// 首字母大写
- (NSString * )stringFirstUpperCase{
    return  [self capitalizedString];
}

#pragma mark 替换 删除 去空格
// 替换
- (NSString * )stringWithOldString:(NSString *)oldString WithNewString:(NSString *)newString{
    return [self stringByReplacingOccurrencesOfString:oldString withString:newString];
}
// 删除
- (NSString *)stringDeleteString:(NSString *)deleteString{
    return [self stringByReplacingOccurrencesOfString:deleteString withString:@""];
}
// 去空格
- (NSString *)stringDeleteSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
// 字符串转字典
-(NSDictionary *)parseJSONStringToNSDictionary{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

#pragma mark 分割 截取
// 截取前面
- (NSString *)stringToIndex:(NSInteger)index{
    return [self substringToIndex:index];
}
// 截取后面
- (NSString *)stringFromIndex:(NSInteger)index{
    return [self substringFromIndex:index];
}
// 分割成数组
- (NSArray *)stringComponentsSeparateWithString:(NSString *)compString{
    return [self componentsSeparatedByString:compString];
}



- (NSString *)hideReplacementCenterNumberFromMobileNumberWithSubIndex:(NSUInteger)subIndex
{
    NSString *resultString = @"";
        NSInteger count = [self contentCharCount];
        if (count > subIndex) {
            resultString = [NSString stringWithFormat:@"%@...",[self stringToIndex:subIndex - 2 ]];
        }
        else {
            resultString = self;
        }     
    if ([resultString isEqualToString:@"null"]) {
        return nil;
    }
    return resultString;
}
//文本内容字符的个数
- (NSInteger)contentCharCount
{
    NSInteger charCount = 0;
    if (self.length == 0) {
        return 0;
    }
    
    for (int i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        
        if (c >=0x4E00 && c <=0x9FA5) {
            charCount = charCount + 2 ;//汉字
        }
        else {
            charCount = charCount + 1;
        }
    }
    return charCount;
}
//// 从count位显示...
//-(NSString *)stringAtIndexByCount:(NSInteger)count
//{
//    int i;
//    int sum=0;
//    for(i=0;i<[self length];i++)
//    {
//        unichar str = [self characterAtIndex:i];
//        if(str < 256){
//            sum+=1;
//        }
//        else {
//            sum+=2;
//        }
//        if(sum>count){
//            //当字符大于count时，剪取三个位置，显示省略号。否则正常显示
//            NSString * str=[self substringWithRange:NSMakeRange(0,[self charAtIndexByCount:self withCount:count-3])];
//            return [NSString stringWithFormat:@"%@...",str];
//        }
//    }
//    return self;
//}
//-(NSInteger)charAtIndexByCount:(NSString *)string withCount:(NSInteger)count
//{
//    int i;
//    int sum=0;
//    int count2=0;
//    for(i=0;i<[string length];i++)
//    {
//        unichar str = [string characterAtIndex:i];
//        if(str < 256){
//            sum+=1;
//        }
//        else {
//            sum+=2;
//        }
//        count2++;
//        if (sum>=count){
//            break;
//        }
//    }
//    if(sum>count){
//        return count2-1;
//    }
//    else
//        return count2;
//}

#pragma mark ************************各种转换************************

#pragma mark 16进制的字符串转16位Data
// 16进制 ,蓝牙常用到
- (NSData *)stringHexToBytesData{
    NSMutableData * data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
// 10进制数转成16
- (NSString *)stringWithHexValueIntString:(NSString *)number{
    int num = [number intValue];
    return [NSString stringWithFormat:@"%x",num];
}
// 16进制数转成10数
- (NSInteger)stringWithIntValueHexString:(NSString *)numString{
    return  strtoul([numString UTF8String], 0, 16);
}
// 10进制数转成16进制0xffff
- (NSString *)stringWithHexValueIntFormat:(NSString *)number{
    int num = [number intValue];
    NSString * hexStr =  [NSString stringWithFormat:@"%x",num];
    switch (hexStr.length) {
        case 1:
        {
            hexStr = [NSString stringWithFormat:@"000%@",hexStr];
        }
            break;
        case 2:
        {
            hexStr = [NSString stringWithFormat:@"00%@",hexStr];
        }
            break;
        case 3:
        {
            hexStr = [NSString stringWithFormat:@"0%@",hexStr];
        }
            break;
            
        default:
            break;
    }
    return hexStr;
}

// 字典转成字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 时间格式转换
- (NSString *)newTimeStringFormtter:(NSString * )newFormtter WithOldFormtter:(NSString *)oldFormetter{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:newFormtter];
    //YYYY-MM-dd HH:mm:ss
    NSDateFormatter  *olddateformatter=[[NSDateFormatter alloc] init];
    [olddateformatter setDateFormat:oldFormetter];
    //YYYYMMddHHmmss
    NSDate * date = [olddateformatter dateFromString:self];
    return  [dateformatter stringFromDate:date];
}
//日期格式转换(yyyy.MM.dd 类型转为 YYYY-MM-dd HH:mm:ss 类型)
-(NSString *)convertToDateString{
    NSString *dateString = @"";
    NSString *cleanStr = [[[self stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDateFormatter *cleanDateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatString = [@"yyyyMMddHHmmss" substringToIndex:cleanStr.length];
    //设定时间格式,这里可以设置成自己需要的格式
    [cleanDateFormatter setDateFormat:formatString];
    //用[NSDate date]可以获取系统当前时间
    NSDate *cureDate = [cleanDateFormatter dateFromString:cleanStr];
    //输出格式为：2010-10-27 10:22:13
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    NSString *lastFormatString = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setDateFormat:lastFormatString];
    //用[NSDate date]可以获取系统当前时间
    dateString = [dateFormatter stringFromDate:cureDate];
    
    return dateString;
}

// 根据时间戳类型计算距离当前日期
- (NSString *)intervalSinceNow
{
    NSString *timeString=@"";
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:self];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = labs((long)intervalTime);
    //    NSInteger iMonth =lTime/60/60/24/12;
    //    NSInteger iYears = lTime/60/60/24/384;
    NSInteger iDays = lTime/60/60/24;
//    NSInteger iHours = labs(lTime/60/60);
//    NSInteger iMinutes = (lTime / 60) % 60;
    //    NSInteger iSeconds =  lTime % 60;
    
//    if (iHours<1 && iMinutes>0)
//    {
//        timeString=[NSString stringWithFormat:@"%ld分",(long)iMinutes];
//        
//    }else if (iHours>0&&iDays<1 && iMinutes>0) {
//        timeString=[NSString stringWithFormat:@"%ld时%ld分",(long)iHours,(long)iMinutes];
//    }
//    else if (iHours>0&&iDays<1) {
//        timeString=[NSString stringWithFormat:@"%ld时",(long)iHours];
//    }else if (iDays>0 && iHours>0)
//    {
//        timeString=[NSString stringWithFormat:@"%ld天%ld时",(long)iDays,(long)(iHours - iDays*24)];
//    }
//    else
    
    if (iDays>0)
    {
        timeString=[NSString stringWithFormat:@"%ld",(long)iDays];
    }else{
        timeString=[NSString stringWithFormat:@"%@",@"0"];
    }
    return timeString;
}
//日期叠加
- (NSString *)dateStringAfterlocalDateForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //日期格式转为时间戳类型
    NSDate* localDate = [formatter dateFromString:[self convertToDateString]];
    // 在当前日期时间加上 时间：格里高利历
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponent = [[NSDateComponents alloc]init];
    [offsetComponent setYear:year ];  // 设置开始时间为当前时间的前x年
    [offsetComponent setMonth:month];
    [offsetComponent setDay:day];
    [offsetComponent setHour:(hour+8)]; // 中国时区为正八区，未处理为本地，所以+8
    [offsetComponent setMinute:minute];
    [offsetComponent setSecond:second];
    // 开始时间后若干时间
    NSDate *minDate = [gregorian dateByAddingComponents:offsetComponent toDate:localDate options:0];
    NSString *dateString = [NSString stringWithFormat:@"%@",minDate];
    dateString = [self convertToDateStringWithStr:dateString];//YYYY-MM-dd HH:mm:ss +0000 类型转为 yyyy.MM.dd类型
    return dateString;
}
//日期格式转换(YYYY-MM-dd HH:mm:ss +0000 类型转为 yyyy.MM.dd类型)
-(NSString *)convertToDateStringWithStr:(NSString *)str{
    NSString *dateString = @"";
    NSString *cleanStr = [[[[str stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSDateFormatter *cleanDateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatString = [@"yyyyMMddHHmmss0000" substringToIndex:cleanStr.length];
    //设定时间格式,这里可以设置成自己需要的格式
    [cleanDateFormatter setDateFormat:formatString];
    //用[NSDate date]可以获取系统当前时间
    NSDate *cureDate = [cleanDateFormatter dateFromString:cleanStr];
    //输出格式为：2010-10-27 10:22:13
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    NSString *lastFormatString = @"yyyy.MM.dd";
    [dateFormatter setDateFormat:lastFormatString];
    dateString = [dateFormatter stringFromDate:cureDate];
    return dateString;
}

+ (NSString *)dateWithOldDay:(int)index WithDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
    [cmp setDay:[cmp day] - index];
    NSDate *lastMonDate = [calender dateFromComponents:cmp];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    NSString * timeString = [dateformatter stringFromDate:lastMonDate];
    return timeString;
}
+ (NSDate *)dateWithOldDaydate:(int)index WithDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
    [cmp setDay:[cmp day] - index];
    NSDate *lastMonDate = [calender dateFromComponents:cmp];
    return lastMonDate;
}
+ (NSString *)dateWithOldMonth:(int)index{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[[NSDate alloc] init]];
    [cmp setMonth:[cmp month] - index];
    NSDate *lastMonDate = [calender dateFromComponents:cmp];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMM"];
    NSString * timeString = [dateformatter stringFromDate:lastMonDate];
    return timeString;
}

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta;
    NSDate *dtb;
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    switch (result) {
        case NSOrderedSame:
        {
            aa = 0;
        }
            break;
        case NSOrderedAscending:
        {
             //bDate比aDate大
            aa = -1;
        }
            break;
        case NSOrderedDescending:
        {
            //bDate比aDate小
            aa = 1;
        }
            break;
            
        default:
            break;
    }
    return  aa;
}

+ (NSInteger)compareDayDate:(NSString*)startDate withDate:(NSString*)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:startDate];
    NSDate *toDate = [dateFormatter dateFromString:endDate];
    NSDateComponents * dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}


+ (NSString *)decimalNumberWithDouble:(double)doubleValue{
    NSString *doubleString        = [NSString stringWithFormat:@"%.2lf", doubleValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
// 拿到一个月最小天和最大天
+ (NSArray *)dateMinDayAndMaxDayWithDate:(NSString *)date{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMM"];
    NSDate *newDate=[format dateFromString:date];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSArray * arrays =  @[beginString,endString];
    return arrays;
}
@end
