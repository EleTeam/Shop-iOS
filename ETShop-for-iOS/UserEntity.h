//
//  UserEntity.h
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

@interface UserEntity : BaseEntity

@property (nonatomic, copy) NSString *loginName;// 登录名
@property (nonatomic, copy) NSString *name;	// 姓名
@property (nonatomic, copy) NSString *email;	// 邮箱
@property (nonatomic, copy) NSString *phone;	// 电话
@property (nonatomic, copy) NSString *mobile;	// 手机
@property (nonatomic, copy) NSString *userType;// 用户类型
@property (nonatomic, copy) NSString *loginIp;	// 最后登陆IP
@property (nonatomic, copy) NSString *loginDate;	// 最后登陆日期
@property (nonatomic, copy) NSString *photo;	// 头像
@property (nonatomic, copy) NSString *latestPayType;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *access_token;

@end
