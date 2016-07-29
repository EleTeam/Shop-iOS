//
//  Utils.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "Utils.h"

@implementation Utils

+ (NSString *)documentFilePath:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:filename];
    return filePath;
}

+ (NSURL *)documentDirectory {
    NSArray<NSURL *> *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    //NSLog(@"%@", [paths lastObject]);
    return [paths lastObject];
}

+ (AppDelegate *)appDelegate {
    return [[UIApplication sharedApplication] delegate];
}

+ (NSData *)doGetData:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:nil
                                                       error:nil];
    return data;
}
+ (NSString *)doGetString:(NSString *)urlStr {
    NSData *data = [self doGetData:urlStr];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
+ (NSDictionary *)doGetJson:(NSString *)urlStr {
    NSData *data = [self doGetData:urlStr];
    NSDictionary *dict;
    if (data) {
        dict = [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingMutableLeaves
                                                 error:nil];
    }
    return dict;
}

@end
