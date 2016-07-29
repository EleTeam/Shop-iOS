//
//  AreaEntity.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/19.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"

@interface AreaEntity : BaseEntity

@property (nonatomic, copy) NSString *name; 	// 区域名称
@property (nonatomic, copy) NSNumber *sort;		// 排序
@property (nonatomic, copy) NSString *type; 	// 区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）
@property (nonatomic, copy) NSString *simpleName; //简称
@property (nonatomic, copy) NSNumber *level;
@property (nonatomic, copy) NSString *pathIds; //id路径，包括本id
@property (nonatomic, copy) NSString *pathNames; //name路径，包括本name
@property (nonatomic, copy) NSString *zipCode; //邮政编码
@property (nonatomic, copy) NSString *pathNames4Print;

@end
