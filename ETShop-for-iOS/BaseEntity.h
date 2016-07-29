//
//  BaseEntity.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/26.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

/**
 * 根实体，所有实体都必须继承它
 *  自定义的对象必须用strong属性，如果用copy属性将会导致错误（WhichEntity copyWithZone:]: unrecognized selector sent to instance）
 */

@interface BaseEntity : Jastor

@property (nonatomic, copy) NSString *id;

@end
