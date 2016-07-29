//
//  StringUtil.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/25.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "StringUtil.h"

@implementation StringUtil

+ (NSString *)trim:(NSString *)string
{
    //去除两端空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除两端空格和回车
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return string;
}

@end
