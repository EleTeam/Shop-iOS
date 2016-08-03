//
//  Area.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface Area : NSObject

//获得系统默认的区域信息
+ (void)getPrefixChainedAreas:(void(^)(BOOL status, NSNumber *code, NSString *message, Area *area, NSArray *chainedAreas))success
                       failure:(void(^)(NSError *error))failure;

@end
