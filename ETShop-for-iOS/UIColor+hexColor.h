//
//  UIColor+hexColor.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

@interface UIColor (hexColor)

//十六进制表示如：#a0a0a0
+ (UIColor *)hexColor:(NSString *)hexStr;

@end
