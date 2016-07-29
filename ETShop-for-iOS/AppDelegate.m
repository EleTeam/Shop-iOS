//
//  AppDelegate.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AppDelegate.h"
#import "TabHomeController.h"
#import "TabTopicController.h"
#import "TabCartController.h"
#import "TabMyController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self rootController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - methods

- (UITabBarController *)rootController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    //home tab
    TabHomeController *homeController = [[TabHomeController alloc] init];
    homeController.tabBarItem = [self createTabBarItem:@"首页" imageNamed:@"tab_home" selectedImageNamed:@"tab_home_s"];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    
    //topic tab
    TabTopicController *topicController = [[TabTopicController alloc] init];
    topicController.tabBarItem = [self createTabBarItem:@"优惠" imageNamed:@"tab_topic" selectedImageNamed:@"tab_topic_s"];
    UINavigationController *topicNavController = [[UINavigationController alloc] initWithRootViewController:topicController];
    
    //cart tab
    TabCartController *cartController = [[TabCartController alloc] init];
    cartController.tabBarItem = [self createTabBarItem:@"购物车" imageNamed:@"tab_cart" selectedImageNamed:@"tab_cart_s"];
    UINavigationController *cartNavController = [[UINavigationController alloc] initWithRootViewController:cartController];
    
    //my tab
    TabMyController *myController = [[TabMyController alloc] init];
    myController.tabBarItem = [self createTabBarItem:@"我的" imageNamed:@"tab_my" selectedImageNamed:@"tab_my_s"];
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:myController];
    
    tabBarController.viewControllers = @[homeNavController, topicNavController, cartNavController, myNavController];
    
    return tabBarController;
}

- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    return tabBarItem;
}

@end
