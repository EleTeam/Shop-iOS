//
//  BaseLoadingView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/26.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseLoadingView.h"

@interface BaseLoadingView ()
{
    UIActivityIndicatorView *_loadingView;
}

@end

@implementation BaseLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect selfFrame = CGRectMake(frame.origin.x, frame.origin.y, 32, 32);
    if (self = [super initWithFrame:selfFrame]) {
        self.backgroundColor = kColorBackgound;
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [_loadingView startAnimating];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_loadingView.frame.origin.x - 20, _loadingView.frame.origin.y + 40, 100, 100)];
//        imageView.image = [UIImage imageNamed:@"loading_bg"];
        
        [self addSubview:_loadingView];
//        [self addSubview:imageView];
    }
    return self;
}

//- (void)removeFromSuperview
//{
//    [super removeFromSuperview];
//    
//    if(_loadingView) {
//        [_loadingView stopAnimating];
//    }
//}

@end
