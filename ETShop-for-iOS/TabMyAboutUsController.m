//
//  TabMyAboutUsController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 16/3/15.
//  Copyright © 2016年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//  @open source https://github.com/YKXMall
//  @license The MIT License (MIT)
//

#import "TabMyAboutUsController.h"

@interface TabMyAboutUsController ()

@end

@implementation TabMyAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    UILabel *label = [UILabel new];
    label.text = @"月光茶人-饮品界NO.1";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(100);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
