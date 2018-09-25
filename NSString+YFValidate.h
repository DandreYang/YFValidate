//
//  YFValidate.h
//  YFValidate
//
//  Created by Dandre on 2018/9/20.
//  Copyright © 2018年 Dandre Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYFValidateRegexEmail;           // 邮箱正则表达式
extern NSString *const kYFValidateRegexMobile;          // 手机号正则表达式
extern NSString *const kYFValidateRegexPhoneNumber;     // 电话号码正则表达式
extern NSString *const kYFValidateRegexURL;             // URL正则表达式
extern NSString *const kYFValidateRegexPlateNumber;     // 车牌号码正则表达式
extern NSString *const kYFValidateRegexIDCardNumber;    // 身份证号码正则表达式（未验证校验码）


@interface NSString (YFValidate)

/**
 根据指定正则验证字符串格式是否合法

 @param regex 正则表达式
 @return YES/NO
 */
- (BOOL)yf_validateWithRegex:(NSString *)regex;

/**
 判断是否为整形
 
 @return YES/NO
 */
- (BOOL)yf_isIntValue;

/**
 判断是否为浮点形

 @return YES/NO
 */
- (BOOL)yf_isFloatValue;

/**
 是否是有效日期格式
 
 @param format 格式化字符串，为nil时，默认为yyyy-MM-dd
 
 @return YES/NO
 */
- (BOOL)yf_isDateValueWithFormat:(NSString *)format;

/**
 验证URL地址
 
 @return YES/NO
 */
- (BOOL)yf_isURLValue;

/**
 验证邮箱

 @return YES/NO
 */
- (BOOL)yf_isEmail;

/**
 验证手机号（模糊，只验证格式）
 
 @return YES/NO
 */
- (BOOL)yf_isMobile;

/**
 验证是否是电话号码

 @return YES/NO
 */
- (BOOL)yf_isPhoneNumber;

/**
 验证车牌号
 
 @return YES/NO
 */
- (BOOL)yf_isPlateNumber;

/**
 车架号(vin)验证

 @return YES/NO
 */
- (BOOL)yf_isVin;

/**
 银行卡验证

 @return YES/NO
 */
- (BOOL)yf_isBankCardNumber;

/**
 身份证号校验
 
 @return YES/NO
 */
- (BOOL)yf_isIDCardNumber;

/**
 判断是否是有效的中文名
 
 @return 如果是在如下规则下符合的中文名则返回`YES`，否则返回`NO`
 限制规则：
 1. 首先是名字要大于2个汉字，小于8个汉字
 2. 如果是中间带`{•|·}`的名字，则限制长度15位（新疆人的名字有15位左右的，之前公司实名认证就遇到过），如果有更长的，请自行修改长度限制
 3. 如果是不带小点的正常名字，限制长度为8位，若果觉得不适，请自行修改位数限制
 *PS: `•`或`·`具体是那个点具体处理需要注意*
 */
- (BOOL)yf_isChineseName;

@end

NS_ASSUME_NONNULL_END
