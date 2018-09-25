//
//  YFValidate.m
//  YFValidate
//
//  Created by Dandre on 2018/9/20.
//  Copyright © 2018年 Dandre Yang. All rights reserved.
//

#import "NSString+YFValidate.h"

NSString *const kYFValidateRegexEmail           = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
NSString *const kYFValidateRegexMobile          = @"^((13[0-9])|(14[^4,\\D])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0,0-9])|199)\\d{8}$";
NSString *const kYFValidateRegexPhoneNumber     = @"^[0][0-9]{2,3}([-])[0-9](7,8)$";
NSString *const kYFValidateRegexPlateNumber     = @"([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{1}(([A-HJ-Z]{1}[A-HJ-NP-Z0-9]{5})|([A-HJ-Z]{1}(([DF]{1}[A-HJ-NP-Z0-9]{1}[0-9]{4})|([0-9]{5}[DF]{1})))|([A-HJ-Z]{1}[A-D0-9]{1}[0-9]{3}警)))|([0-9]{6}使)|((([沪粤川云桂鄂陕蒙藏黑辽渝]{1}A)|鲁B|闽D|蒙E|蒙H)[0-9]{4}领)|(WJ[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼·•]{1}[0-9]{4}[TDSHBXJ0-9]{1})|([VKHBSLJNGCE]{1}[A-DJ-PR-TVY]{1}[0-9]{5})";
NSString *const kYFValidateRegexURL     =   @"((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+([/?#]\\S*)?";

NSString *const kYFValidateRegexLeapYear         = @"(19|20)(0[48]|[2468][048]|[13579][26])";
NSString *const kYFValidateRegexLeapMonthDay     = @"0229";
NSString *const kYFValidateRegexYear             = @"(19|20)[0-9]{2}";
NSString *const kYFValidateRegexMonthDay         = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
NSString *const kYFValidateRegexIDCardAreaCode   = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
NSString *const kYFValidateRegexIDCardNumber     = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}(((19|20)[0-9]{2}(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8]))))|((19|20)(0[48]|[2468][048]|[13579][26])0229)|(20000229))[0-9]{3}[0-9Xx]";

@implementation NSString (YFValidate)

#pragma mark - 根据指定正则验证字符串格式是否合法
- (BOOL)yf_validateWithRegex:(NSString *)regex {
    if (regex == nil || regex.length == 0) {
        return YES;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 判断是否为整形
- (BOOL)yf_isIntValue {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 判断是否为浮点形
- (BOOL)yf_isFloatValue {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark - 是否是有效日期格式
- (BOOL)yf_isDateValueWithFormat:(NSString *)format {
    NSString *dateString = self.copy;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format.length?format:@"yyyy-MM-dd"];
    NSDate *date = [dateformatter dateFromString:dateString];
    if (date) {
        return YES;
    }
    return NO;
}

#pragma mark - 验证URL地址是否合法
- (BOOL)yf_isURLValue {
    return [self yf_validateWithRegex:kYFValidateRegexURL];
}

#pragma mark - 验证邮箱
- (BOOL)yf_isEmail {
    return [self yf_validateWithRegex:kYFValidateRegexEmail];
}

#pragma mark - 验证手机号码（模糊）
- (BOOL)yf_isMobile {
    return [self yf_validateWithRegex:kYFValidateRegexMobile];
}

#pragma mark 验证电话号码
- (BOOL)yf_isPhoneNumber {
    return [self yf_validateWithRegex:kYFValidateRegexPhoneNumber];
}

#pragma mark - 是否是车牌号码
- (BOOL)yf_isPlateNumber {
    return [self yf_validateWithRegex:kYFValidateRegexPlateNumber];
}

#pragma mark - 是否是车架号
- (BOOL)yf_isVin {
    NSArray<NSNumber *> *vinMapWeighting = @[@8,@7,@6,@5,@4,@3,@2,@10,@0,@9,@8,@7,@6,@5,@4,@3,@2];
    NSDictionary<NSString *, NSNumber *> *vinMapValue = @{@"0":@0,
                                                          @"1":@1,
                                                          @"2":@2,
                                                          @"3":@3,
                                                          @"4":@4,
                                                          @"5":@5,
                                                          @"6":@6,
                                                          @"7":@7,
                                                          @"8":@8,
                                                          @"9":@9,
                                                          @"A":@1,
                                                          @"B":@2,
                                                          @"C":@3,
                                                          @"D":@4,
                                                          @"E":@5,
                                                          @"F":@6,
                                                          @"G":@7,
                                                          @"H":@8,
                                                          @"J":@1,
                                                          @"K":@2,
                                                          @"L":@3,
                                                          @"M":@4,
                                                          @"N":@5,
                                                          @"P":@7,
                                                          @"R":@9,
                                                          @"S":@2,
                                                          @"T":@3,
                                                          @"U":@4,
                                                          @"V":@5,
                                                          @"W":@6,
                                                          @"X":@7,
                                                          @"Y":@8,
                                                          @"Z":@9};
    
    NSString *uppervin = self.uppercaseString;
    
    if (self.length == 0 || [uppervin containsString:@"O"] || [uppervin containsString:@"I"] || [uppervin containsString:@"Q"] || self.length != 17) {
        return NO;
    }
    
    int amount = 0;
    for (int i = 0; i< uppervin.length; i++) {
        char cStr = [uppervin characterAtIndex:i];
        NSString * str = [[NSString alloc] initWithFormat:@"%c",cStr];
        //VIN码从从第一位开始，码数字的对应值×该位的加权值，计算全部17位的乘积值相加
        amount += vinMapValue[str].integerValue * vinMapWeighting[i].integerValue;
    }
    
    char cStr = [uppervin characterAtIndex:8];
    NSString *str = [[NSString alloc] initWithFormat:@"%c",cStr];
    
    //乘积值相加除以11、若余数为10，即为字母Ｘ
    if (amount % 11 == 10) {
        if (cStr == 'X') {
            return YES;
        } else {
            return NO;
        }
    } else {
        //VIN码从从第一位开始，码数字的对应值×该位的加权值，
        //计算全部17位的乘积值相加除以11，所得的余数，即为第九位校验值
        if (amount % 11 != vinMapValue[str].integerValue) {
            return NO;
        } else {
            return YES;
        }
    }
}

#pragma mark - 银行卡验证
/*
 校验过程：
 1、从卡号最后一位数字开始，逆向将奇数位(1、3、5等等)相加。
 2、从卡号最后一位数字开始，逆向将偶数位数字，先乘以2（如果乘积为两位数，将个位十位数字相加，即将其减去9），再求和。
 3、将奇数位总和加上偶数位总和，结果应该可以被10整除。
 */
/**
 * 校验银行卡卡号
 */
- (BOOL)yf_isBankCardNumber {
    if(self.length < 15 || self.length > 19) {
        return NO;
    }
    
    NSRange range = NSMakeRange(0, self.length -1);
    
    char bit = [self getBankCardCheckCode:[self substringWithRange:range]];
    if(bit == 'N'){
        return NO;
    }
    return [self characterAtIndex:self.length - 1] == bit;
}

/**
 * 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位
 * @param nonCheckCodeBankCard 卡号
 * @return char
 */
- (char)getBankCardCheckCode:(NSString *)nonCheckCodeBankCard {
    if(nonCheckCodeBankCard.length == 0 || !nonCheckCodeBankCard.yf_isIntValue) {
        //如果传的不是数据返回N
        return 'N';
    }
    
    int luhmSum = 0;
    for(NSInteger i = nonCheckCodeBankCard.length - 1, j = 0; i >= 0; i--, j++) {
        int k = [nonCheckCodeBankCard characterAtIndex:i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    return (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
}

#pragma mark - 身份证号码验证
- (BOOL)yf_isIDCardNumber {
    NSString *IDCardNumber = self.copy;
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18) {
        return NO;
    }

    if (![self yf_validateWithRegex:kYFValidateRegexIDCardNumber]) {
        return NO;
    }
    
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

#pragma mark - 判断是否是有效的中文名
- (BOOL)yf_isChineseName {
    NSString *realName = self.copy;
    if (realName.length == 0) return NO;
    
    if ([[realName stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        return NO;
    }
    
    NSRange range1 = [realName rangeOfString:@"·"];
    NSRange range2 = [realName rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        // 一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }else {
        // 一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 8) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}

@end
