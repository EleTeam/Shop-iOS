//
//  ProductInfoCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductInfoCell.h"
#import "SDCycleScrollView.h"

@interface ProductInfoCell ()
{
    SDCycleScrollView *scrollView;
    UILabel           *nameView;
    UILabel           *curPriceView;
    UILabel           *oriPriceView;
    UILabel           *shortDescView;
}

@end

@implementation ProductInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(Product *)product
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //padding
        CGFloat leftMargin = 8;
        CGFloat marginWidth = 8;
        CGFloat marginHeight = 12;

        //scrollView, 网络加载轮播图
        CGFloat scrollViewHeight = 260;
        scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollViewHeight)];
        NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
        if (product.app_long_image1 && product.app_long_image1.length > 4) {
            [imagesURLStrings addObject:product.app_long_image1];
        }
        if (product.app_long_image2 && product.app_long_image2.length > 4) {
            [imagesURLStrings addObject:product.app_long_image2];
        }
        if (product.app_long_image3 && product.app_long_image3.length > 4) {
            [imagesURLStrings addObject:product.app_long_image3];
        }
        if (product.app_long_image4 && product.app_long_image4.length > 4) {
            [imagesURLStrings addObject:product.app_long_image4];
        }
        if (product.app_long_image5 && product.app_long_image5.length > 4) {
            [imagesURLStrings addObject:product.app_long_image5];
        }
        scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //scrollView.bannerImageViewContentMode = UIViewContentModeCenter;
        scrollView.imageURLStringsGroup = imagesURLStrings;
        //scrollView.delegate = self;
        //self.cycleScrollView.titlesGroup = titles;
        //self.cycleScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
        scrollView.placeholderImage = [UIImage imageNamed:@"image_holder_long"];
        
        //nameView
        CGFloat nameViewWidth = kScreenWidth / 2 - 20;
        CGFloat nameViewHeight = 20;
        nameView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, scrollViewHeight + marginWidth, nameViewWidth, nameViewHeight)];
        nameView.font = [UIFont systemFontOfSize:nameViewHeight];
        nameView.text = product.name;
        //nameView.backgroundColor = kBackgoundColor;
        
        //price views
        CGFloat curPriceViewWidth = 80;
        CGFloat curPriceViewHeight = 20;
        float reducePriceFloat = [product.price floatValue] - [product.featured_price floatValue];
        CGRect curPriceViewRect = CGRectMake(leftMargin + nameViewWidth + marginWidth, scrollViewHeight + marginHeight, curPriceViewWidth, curPriceViewHeight);
        if (product.featured_price && [product.featured_price floatValue] > 0 && reducePriceFloat > 0) {
            CGRect oriPriceViewRect = CGRectMake(leftMargin + nameViewWidth + marginWidth + curPriceViewWidth + marginWidth, scrollViewHeight + marginHeight, curPriceViewWidth, curPriceViewHeight);
            curPriceView = [[PriceLabel alloc] initWithFrame:curPriceViewRect curPrice:product.featured_price];
            oriPriceView = [[PriceLabel alloc] initWithFrame:oriPriceViewRect oriPrice:product.price];
        } else {
            curPriceView = [[PriceLabel alloc] initWithFrame:curPriceViewRect curPrice:product.price];
        }
        
        //shortDescView
        CGFloat shortDescViewHeight = 0;
        if (product.short_description && product.short_description.length > 0) {
            shortDescViewHeight = 40;
            shortDescView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, scrollViewHeight + marginWidth + nameViewHeight + marginHeight, kScreenWidth - leftMargin - 3, shortDescViewHeight)];
            shortDescView.font = [UIFont systemFontOfSize:16];
            shortDescView.numberOfLines = 2;
            shortDescView.text = product.short_description;
            //shortDescView.backgroundColor = kBackgoundColor;
        }
        
        //attrItems
        
        
        [self addSubview:scrollView];
        [self addSubview:nameView];
        [self addSubview:curPriceView];
        [self addSubview:oriPriceView];
        [self addSubview:shortDescView];
    }
    
    return self;
}

+ (CGFloat)heightWithNoShortDescription
{
    return 320;
}

+ (CGFloat)heightWithShortDescription
{
    return [self heightWithNoShortDescription] + 40;
}

@end
