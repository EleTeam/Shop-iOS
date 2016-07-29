//
//  ProductBottomView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductBottomView.h"

@interface ProductBottomView ()
{
    ProductForm *_productForm;
    
    //底部栏划分为3个方格
    UIView *grid1;
    UIView *grid2;
    UIView *grid3;
    
    UIImageView *collectImageView;
    UILabel *collectTitleLabel;
    
    UIButton *cartBtn;
    UIImageView *cartImageView;
    UILabel *cart_numLabel;
    UILabel *cartTitleLabel;
    
    UIButton *addBtn;
    
    //点击加入购物车按钮后显示这两个加载中的视图，操作后则隐藏
    UIActivityIndicatorView *cartLoadingViewInGrid2;
    UIActivityIndicatorView *cartLoadingViewInGrid3;
}

@end

@implementation ProductBottomView

+ (CGFloat)height
{
    return 44;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //底部栏划分为3个方格
        CGFloat height = [ProductBottomView height];
        CGFloat grid1Width = kScreenWidth * 0.3;
        CGFloat grid2Width = kScreenWidth * 0.3;
        CGFloat grid3Width = kScreenWidth * 0.4;
        grid1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grid1Width, height)];
        grid2 = [[UIView alloc] initWithFrame:CGRectMake(grid1Width, 0, grid2Width, height)];
        grid3 = [[UIView alloc] initWithFrame:CGRectMake(grid1Width + grid2Width, 0, grid3Width, height)];
        grid1.backgroundColor = kColorBlack;
        grid2.backgroundColor = kColorBlack;
        grid3.backgroundColor = kColorBlack;
        [self addSubview:grid1];
        [self addSubview:grid2];
        [self addSubview:grid3];
        
        //公用变量
        CGFloat gridImageWidth = 24;
        CGFloat gridImageHeight = 24;
        CGFloat gridTopMargin = 3;
        CGFloat gridTitleTopMargin = 2;
        CGFloat gridTitleTop = gridTopMargin + gridImageHeight + gridTitleTopMargin;
        UIFont *gridTitleFont = [UIFont systemFontOfSize:12];
        UIColor *gridTitleColor = kColorWhite;
        
        //第一个方格
        collectImageView = [UIImageView new];
        collectImageView.image = [UIImage imageNamed:@"collect"];
        collectTitleLabel = [UILabel new];
        collectTitleLabel.text = @"收藏";
        collectTitleLabel.textColor = gridTitleColor;
        collectTitleLabel.font = gridTitleFont;
        [grid1 addSubview:collectImageView];
        [grid1 addSubview:collectTitleLabel];
        
        [collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid1.mas_centerX);
            make.top.mas_equalTo(gridTopMargin);
            make.width.mas_equalTo(gridImageWidth);
            make.height.mas_equalTo(gridImageHeight);
        }];
        [collectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid1.mas_centerX);
            make.top.mas_equalTo(gridTitleTop);
        }];
        //collectImageView.backgroundColor = kRedColor;
        //collectTitleLabel.backgroundColor = kRedColor;
        
        //第二方格
        cartBtn = [UIButton new];
        [grid2 addSubview:cartBtn];
        [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(grid2);
            make.top.equalTo(grid2);
            make.width.equalTo(grid2);
            make.height.equalTo(grid2);
        }];
        
        cartImageView = UIImageView.new;
        cartImageView.image = [UIImage imageNamed:@"cart_small"];
        cart_numLabel = [UILabel new];
        cart_numLabel.text = @"0";
        cart_numLabel.font = [UIFont systemFontOfSize:11];
        cart_numLabel.textColor = kColorWhite;
        cart_numLabel.textAlignment = NSTextAlignmentCenter;
        cart_numLabel.layer.cornerRadius = 6;
        cart_numLabel.layer.backgroundColor = kColorRed.CGColor;
        cart_numLabel.hidden = YES;
        cartTitleLabel = [UILabel new];
        cartTitleLabel.text = @"购物车";
        cartTitleLabel.font = gridTitleFont;
        cartTitleLabel.textColor = gridTitleColor;
        
        [cartBtn addSubview:cartImageView];
        [cartBtn addSubview:cart_numLabel];
        [cartBtn addSubview:cartTitleLabel];
        
        [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid2.mas_centerX);
            make.top.mas_equalTo(gridTopMargin);
            make.width.mas_equalTo(gridImageWidth);
            make.height.mas_equalTo(gridImageHeight);
        }];
        [cart_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid2.mas_centerX);
            make.top.mas_equalTo(gridTopMargin * 2);
            make.width.mas_equalTo(gridImageWidth - 8);
            make.height.mas_equalTo(gridImageHeight - 12);
        }];
        [cartTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid2.mas_centerX);
            make.top.mas_equalTo(gridTitleTop);
        }];
        
        //第三方格
        addBtn = [UIButton new];
        addBtn.backgroundColor = kColorMainRed;
        [addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [grid3 addSubview:addBtn];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(grid3.mas_centerX);
            make.centerY.mas_equalTo(grid3.mas_centerY);
            make.top.mas_equalTo(grid3);
            make.width.equalTo(grid3);
        }];
        
        //加入购物车加载中视图
        cartLoadingViewInGrid2 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        cartLoadingViewInGrid2.center = CGPointMake(grid1Width + grid2.frame.size.width / 2, grid2.frame.size.height / 2);
        
        cartLoadingViewInGrid3 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cartLoadingViewInGrid3.center = CGPointMake(grid1Width + grid2Width + grid3.frame.size.width / 2, grid3.frame.size.height / 2);
        
        //添加点击回调方法
        [addBtn addTarget:self action:@selector(submitProductForm) forControlEvents:UIControlEventTouchUpInside];
        [cartBtn addTarget:self action:@selector(clickCartBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setProductForm:(ProductForm *)productForm
                             cart_num:(NSNumber *)cart_num
                hasCollectedProduct:(BOOL)hasCollectedProduct
{
    _productForm = productForm;
    [self setCartNum:cart_num];
    [self setHasCollectedProduct:hasCollectedProduct];
}

- (void)setCartNum:(NSNumber *)cart_num
{
    cart_numLabel.text = [NSString stringWithFormat:@"%@", cart_num];
    cart_numLabel.hidden = NO;
}

- (void)setHasCollectedProduct:(BOOL)hasCollectedProduct
{
    if (hasCollectedProduct) {
        collectImageView.image = [UIImage imageNamed:@"collect_s"];
    } else {
        collectImageView.image = [UIImage imageNamed:@"collect"];
    }
}

- (void)showCartLoadingView
{
    [cartLoadingViewInGrid2 startAnimating];
    [self addSubview:cartLoadingViewInGrid2];
    
    [cartLoadingViewInGrid3 startAnimating];
    [self addSubview:cartLoadingViewInGrid3];
}

- (void)hideCartLoadingView
{
    [cartLoadingViewInGrid2 stopAnimating];
    [cartLoadingViewInGrid2 removeFromSuperview];
    
    [cartLoadingViewInGrid3 stopAnimating];
    [cartLoadingViewInGrid3 removeFromSuperview];
    
}

//加入购物车，提交productForm表单
- (void)submitProductForm
{
    if (self.delegate) {
        [self.delegate doSubmitProductForm];
    }
}

//收藏或取消收藏商品
- (void)collectProduct
{
    if (self.delegate) {
        [self.delegate doCollectProduct];
    }
}

//转到购物车页
- (void)clickCartBtn
{
    [self.delegate doClickCartBtn];
}

@end
