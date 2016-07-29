//
//  DbUtil.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "DbUtil.h"


@interface DbUtil()

//+ (void)initCategoryTable;
//
//+ (void)initProductTable;

@end


@implementation DbUtil

/*
+ (FMDatabase *)db {
    static FMDatabase *db = nil;
    if (db != nil) {
        return db;
    }
    
    NSString *dbPath = [Utils documentFilePath:DB_FILE];
    db = [FMDatabase databaseWithPath:dbPath];
    return db;
}

+ (BOOL)categoryTableExist {
    static BOOL isExist = NO;
    if (isExist) {
        return isExist;
    }
    
    isExist = [self tableExist:DB_TABLE_CATEGORY];
    if (!isExist) {
        NSLog(@"数据表'%@'不存在", DB_TABLE_CATEGORY);
    }
    return isExist;
}

+ (FMDatabase *)openDb {
    FMDatabase *db = [DbUtil db];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    return db;
}

+ (BOOL)productTableExist {
    static BOOL isExist = NO;
    if (isExist) {
        return isExist;
    }
    
    isExist = [self tableExist:DB_TABLE_PRODUCT];
    if (!isExist) {
        NSLog(@"数据表'%@'不存在", DB_TABLE_PRODUCT);
    }
    return isExist;
}

+ (BOOL)tableExist:(NSString *)tableName {
    FMDatabase *db = [self db];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    NSString *existSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    FMResultSet *rs = [db executeQuery:existSql];
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        if (count == 1) {
            [rs close];
            [db close];
            return YES;
        }
    }
    
    [rs close];
    [db close];
    return NO;
}

+ (void)initDb {
    [self initCategoryTable];
    [self initProductTable];
}

+ (void)initCategoryTable {
    if ([self categoryTableExist]) {
        return;
    }
    
    FMDatabase *db = [self db];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    BOOL result = [db executeUpdate:DB_CREATE_TABLE_CATEGORY];
    if (!result) {
        NSLog(@"创建'%@'表失败", DB_TABLE_CATEGORY);
    } else {
        NSLog(@"创建'%@'表成功", DB_TABLE_CATEGORY);
    }
    [db close];
}

+ (void)initProductTable {
    if ([self productTableExist]) {
        return;
    }
    
    FMDatabase *db = [self db];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    BOOL result = [db executeUpdate:DB_CREATE_TABLE_PRODUCT];
    if (!result) {
        NSLog(@"创建'%@'表失败", DB_TABLE_PRODUCT);
    } else {
        NSLog(@"创建'%@'表成功", DB_TABLE_PRODUCT);
    }
    [db close];
}
*/

@end
