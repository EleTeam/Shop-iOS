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

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name; 	// 区域名称
@property (nonatomic, strong) NSNumber *sort;		// 排序
@property (nonatomic, strong) NSNumber *type; 	// 区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）
@property (nonatomic, strong) NSString *simple_name; //简称
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSString *pathIds; //id路径，包括本id
@property (nonatomic, strong) NSString *zip_code; //邮政编码
@property (nonatomic, strong) NSString *path_names; //name路径，包括本name
@property (nonatomic, strong) NSString *path_names_4print; //不存在数据库的字段，path_names去掉前缀"中国/广东省/"

//获得系统默认的区域信息
+ (void)getPrefixChainedAreas:(void(^)(BOOL status, NSNumber *code, NSString *message, Area *area, NSArray *chainedAreas))success
                       failure:(void(^)(NSError *error))failure;

@end
