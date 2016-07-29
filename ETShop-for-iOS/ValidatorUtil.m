//
//  ValidatorUtil.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ValidatorUtil.h"

@implementation ValidatorUtil

//判断是否正确的手机号码
+ (BOOL)isValidMobile:(NSString *)mobile error:(NSError **)error;
{
    NSDictionary *errorUserInfo;
    
    if (mobile.length <= 0) {
        errorUserInfo = [NSDictionary dictionaryWithObject:@"请输入手机号"                                                                      forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:kCustomErrorDomain code:eCustomErrorCodeFailure userInfo:errorUserInfo];
        return NO;
    }
    
    if (mobile.length != 11) {
        errorUserInfo = [NSDictionary dictionaryWithObject:@"手机号长度只能是11位"                                                                      forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:kCustomErrorDomain code:eCustomErrorCodeFailure userInfo:errorUserInfo];
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            errorUserInfo = [NSDictionary dictionaryWithObject:@"请输入正确的电话号码"                                                                      forKey:NSLocalizedDescriptionKey];
            *error = [NSError errorWithDomain:kCustomErrorDomain code:eCustomErrorCodeFailure userInfo:errorUserInfo];
            return NO;
        }
    }
}

//判断是否正确的密码格式
+ (BOOL)isValidPassword:(NSString *)password error:(NSError **)error
{
    NSDictionary *errorUserInfo;
    
    if (password.length < 6) {
        errorUserInfo = [NSDictionary dictionaryWithObject:@"密码长度必须六位以上" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:kCustomErrorDomain code:eCustomErrorCodeFailure userInfo:errorUserInfo];
        return NO;
    }
    
    return YES;
}

@end
