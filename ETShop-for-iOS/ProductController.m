//
//  ProductController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductController.h"
#import "CartController.h"
#import "Product.h"
#import "ProductInfoCell.h"
#import "ProductAttrCell.h"
#import "ProductForm.h"
#import "ProductBottomView.h"


//测试其他控制的页面
#import "OrderSuccessController.h"
#import "Order.h"


//产品信息块的划分
typedef enum {
    MainTableSection_ProductInfo,
    MainTableSection_ProductAttributes
}MainTableSection;

typedef enum {
    ProductInfoRow_Images,
    ProductInfoRow_Prices,
    ProductInfoRow_ShortDescription,
}ProductInfoRow;

@interface ProductController () <UITableViewDataSource, UITableViewDelegate, ProductBottomViewDelegate>
{
    NSNumber *_product_id;
    Product *_product;
    ProductForm *_productForm;
    
    UITableView *_mainTable;
    ProductBottomView *_bottomView;
}
@end

@implementation ProductController

- (instancetype)initWithProductId:(NSNumber *)product_id {
    if (self = [super init]) {
        _product_id = product_id;
    }
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    //底部操作栏
    CGFloat bottomViewHeight = [ProductBottomView height];
    _bottomView = [[ProductBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - bottomViewHeight, kScreenWidth, bottomViewHeight)];
    _bottomView.delegate = self;
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSelfViewHeight - bottomViewHeight) style:UITableViewStyleGrouped];
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_mainTable];
    [self.view addSubview:_bottomView];
    [self showLoadingView];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [Product getProduct:_product_id success:^(BOOL result, NSNumber *code, NSString *message, Product *product, NSNumber *cart_num, BOOL hasCollectedProduct) {
        if (result) {
            _product = product;
            _productForm = [[ProductForm alloc] initWithProduct:product];
            
            //更新底部栏
            [_bottomView setProductForm:_productForm cart_num:cart_num hasCollectedProduct:hasCollectedProduct];
            
            [_mainTable reloadData];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num = 0;
    if (_product) {
        num ++;
    }
    if (_product.productAttrs.count > 0) {
        num ++;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if(indexPath.section == MainTableSection_ProductInfo) {
        height = [ProductInfoCell heightWithNoShortDescription];
        if (_product.description.length > 0)
            height = [ProductInfoCell heightWithShortDescription];
    }
    else if(indexPath.section == MainTableSection_ProductAttributes) {
        height = [ProductAttrCell heightWithProduct:_product];
    }
    //NSLog(@"%d, %d, %d", indexPath.section, MainTableSection_ProductInfo, MainTableSection_ProductAttributes);
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //产品信息
    if (MainTableSection_ProductInfo == indexPath.section) {
        NSString *identifier = @"productInfoCell";
        ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier product:_product];
        }
        return cell;
    }
    //产品属性
    else {
        NSString *identifier = @"productAttrCell";
        ProductAttrCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ProductAttrCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier product:_product productForm:_productForm];
        }
        return cell;
    }
}


#pragma mark - ProductBottomViewDelegate

/**
 * 添加产品到购物车
 * 服务器会生成唯一的app_cart_cookie_id，必须保存它，每次请求都要提交它
 */
- (void)doSubmitProductForm
{
    if (!_productForm || !_productForm.product_id) {
        return;
    }
    
    [_bottomView showCartLoadingView];
    
    [_productForm submit:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
        if (status) {
            NSNumber *cart_num = [data objectForKey:@"cart_num"];
            NSString *app_cart_cookie_id = [data objectForKey:@"app_cart_cookie_id"];
            
            //更新底部栏的购物车数量
            [_bottomView setCartNum:cart_num];
            //保存app_cart_cookie_id到本地
            if ([app_cart_cookie_id isKindOfClass:[NSString class]] && app_cart_cookie_id.length > 0) {
                [StorageUtil saveAppCartCookieId:app_cart_cookie_id];
            }
        } else {
            [self toast:message];
            
        }
        [_bottomView hideCartLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [_bottomView hideCartLoadingView];
    }];
}

- (void)doCollectProduct
{
    
}

- (void)doClickCartBtn
{
    //测试其他控制的页面
//    OrderEntity *order = [OrderEntity new];
//    order.id = @"fa6f976d48be4690a9cd976fdc5962c7";
//    order.totalPrice = [NSNumber numberWithFloat:55.00];
//    order.serialNo = @"20161212039876543";
//    OrderSuccessController *ctrl1 = [[OrderSuccessController alloc] initWithOrder:order];
//    [self.navigationController pushViewController:ctrl1 animated:YES];
//    return;
    
    CartController *ctrl = [[CartController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}


@end
