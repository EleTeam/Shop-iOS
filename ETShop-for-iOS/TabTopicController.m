//
//  TabTopicController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabTopicController.h"
#import "ProductController.h"
#import "Product.h"
#import "TabTopicTopCell.h"
#import "TabTopicProductCell.h"

@interface TabTopicController () <UITableViewDataSource, UITableViewDelegate, TabTopicTopCellDelegate>
{
    UITableView *_mainTable;
    //TabTopicTopCell *_topCell; //顶部栏
    
    //数据源，数组的值是Product
    NSArray *_featuredProducts;
    NSArray *_topicProducts;
    NSArray *_topSaleProducts;
    NSString *_curTagName; //当前选中的顶部标签：featuredTag, topicTag, topSaleTag
}
@end


@implementation TabTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"优惠";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    _curTagName = @"featuredTag";
    [self.view addSubview:_mainTable];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getData
{
    [self getFeaturedProducts];
}

//逐个依次完成网络请求，避免同时发送多个请求造成堵塞
- (void)getFeaturedProducts
{
    __weak typeof (self) weakSelf = self;
    [self showLoadingView];
    
    [Product getFeaturedProducts:^(BOOL result, NSString *message, NSArray *products) {
        if (result) {
            _featuredProducts = products;
            [_mainTable reloadData];
            
            //继续下一个请求
            [self getTopicProducts];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
        [weakSelf hideNetworkBrokenView];
    } failure:^(NSError *error) {
        //网络没有连接
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showNetworkBrokenView:nil];
        } else {
            [weakSelf toastWithError:error];
        }
        [weakSelf hideLoadingView];
    }];
}

-(void)getTopicProducts
{
    [Product getTopicProducts:^(BOOL result, NSString *message, NSArray *products) {
        if (result) {
            _topicProducts = products;
            [_mainTable reloadData];
            
            //继续下一个请求
            [self getTopSaleProducts];
        } else {
            [self toast:message];
        }
    } failure:^(NSError *error) {
        [self toastWithError:error];
    }];
}

-(void)getTopSaleProducts
{
    [Product getTopSaleProducts:^(BOOL result, NSString *message, NSArray *products) {
        if (result) {
            _topSaleProducts = products;
            [_mainTable reloadData];
        } else {
            [self toast:message];
        }
    } failure:^(NSError *error) {
        [self toastWithError:error];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    //顶部栏
    if (section == 0) {
        return 1;
    }
    //内容栏
    else if (section == 1) {
        if ([@"featuredTag" isEqualToString:_curTagName]) {
            num = _featuredProducts.count;
        }
        else if ([@"topicTag" isEqualToString:_curTagName]) {
            num = _topicProducts.count;
        }
        else if ([@"topSaleTag" isEqualToString:_curTagName]) {
            num = _topSaleProducts.count;
        }
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //顶部栏的Cell
    if (indexPath.section == 0) {
        NSString *identifier = @"TabTopicTopCell";
        TabTopicTopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TabTopicTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    //内容栏的Cell
    else {
        Product *product = nil;
        if ([@"featuredTag" isEqualToString:_curTagName]) {
            product = _featuredProducts[indexPath.row];
        }
        else if ([@"topicTag" isEqualToString:_curTagName]) {
            product = _topicProducts[indexPath.row];
        }
        else if ([@"topSaleTag" isEqualToString:_curTagName]) {
            product = _topSaleProducts[indexPath.row];
        }
        
        NSString *identifier = @"TabTopicProductCell";
        TabTopicProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TabTopicProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell fillContentWithProduct:product tagName:_curTagName];
        
        tableView.separatorStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    //顶部栏的高度
    if (indexPath.section == 0) {
        height = [TabTopicTopCell height];
    }
    //内容栏的高度
    else if (indexPath.section == 1) {
        height = [TabTopicProductCell height];
    }
    return height;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = nil;
    if ([@"featuredTag" isEqualToString:_curTagName]) {
        product = _featuredProducts[indexPath.row];
    }
    else if ([@"topicTag" isEqualToString:_curTagName]) {
        product = _topicProducts[indexPath.row];
    }
    else if ([@"topSaleTag" isEqualToString:_curTagName]) {
        product = _topSaleProducts[indexPath.row];
    }
    
    ProductController *ctrl = [[ProductController alloc] initWithProductId:product.id];
    [self.navigationController pushViewController:ctrl animated:YES];
}


#pragma mark - TabTopicTopCell

- (void)doClickFeaturedTag
{
    _curTagName = @"featuredTag";
    [_mainTable reloadData];
}

- (void)doClickTopicTag
{
    _curTagName = @"topicTag";
    [_mainTable reloadData];
}

- (void)doClickTopSaleTag
{
    _curTagName = @"topSaleTag";
    [_mainTable reloadData];
}

- (void)doClickNetworkBrokenView
{
    [self getData];
}

@end
