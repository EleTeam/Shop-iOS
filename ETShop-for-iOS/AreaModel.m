//
//  AreaModel.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/27.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AreaModel.h"

@implementation AreaModel

//获得系统默认的区域信息
+ (void)getPrefixChainedAreas:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, AreaEntity *area, NSArray *chainedAreas))success
                         failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlAreaPrefixChainedAreas;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        AreaEntity *area = nil;
                        NSMutableArray *chainedAreas = [NSMutableArray new];
                        if (result) {
                            NSDictionary *areaDict = [data objectForKey:@"prefixArea"];
                            NSArray *chainedAreaDicts = [data objectForKey:@"areaChainedList"];
                            area = [[AreaEntity alloc] initWithDictionary:areaDict];
                            for (NSDictionary *itemdicts in chainedAreaDicts) {
                                NSDictionary *chainedAreaDict = [itemdicts objectForKey:@"area"];
                                NSArray *childrenDicts = [itemdicts objectForKey:@"children"];
                                AreaEntity *chainedArea = [[AreaEntity alloc] initWithDictionary:chainedAreaDict];
                                NSMutableDictionary *areaItems = [NSMutableDictionary new];
                                
                                NSMutableArray *children = [NSMutableArray new];
                                for (NSDictionary *childDict in childrenDicts) {
                                    AreaEntity *child = [[AreaEntity alloc] initWithDictionary:childDict];
                                    [children addObject:child];
                                }
                                [areaItems setObject:chainedArea forKey:@"area"];
                                [areaItems setObject:children forKey:@"children"];
                                
                                [chainedAreas addObject:areaItems];
                            }
                        }
                        success(result, resultCode, message, area, chainedAreas);
                    }
                    failure:failure];
}

@end
