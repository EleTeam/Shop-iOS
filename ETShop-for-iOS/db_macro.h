//
//  macro.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

//数据库
#define kDbFile                     @"ETShop-for-iOS.sqlite" //ETShop-for-iOS数据库的存放文件
#define kDbTableCategory            @"category"
#define kDbTableProduct             @"product"

//创建数据表
#define kDbCreateTableCategory      @"create table if not exists `"kDbTableCategory"`(`id` varchar(64) primary key not null unique, `name` varchar(20), `sort` integer);"
#define kDbCreateTableProduct       @"create table if not exists `"kDbTableProduct"`(`id` varchar(64) primary key not null unique, `category_id` varchar(64), `name` varchar(100), `image_small` varchar(255), `sort` integer, `price` float, `featured_price` float, `featured_position` integer, `featured_position_sort` integer);"
