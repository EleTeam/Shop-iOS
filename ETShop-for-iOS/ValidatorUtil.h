//
//  ValidatorUtil.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/22.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>

@interface ValidatorUtil : NSObject

//判断是否正确的手机号码格式
+ (BOOL)isValidMobile:(NSString *)mobile error:(NSError **)error;

//判断是否正确的密码格式
+ (BOOL)isValidPassword:(NSString *)password error:(NSError **)error;

@end
