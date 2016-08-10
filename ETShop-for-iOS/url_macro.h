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

//网站地址
#define kUrlBase                        @"http://local.eleteamapi.ygcr8.com/v1" //本地地址
//#define kUrlBase                        @"http://eleteamapi.ygcr8.com/v1" //在线服务器
#define kUrlCategoryListWithProduct     kUrlBase@"/category/list-with-product"
//#define kUrlCategoryList                kUrlBase@"/app/category/list"
//#define kUrlCategoryListWithProduct     kUrlBase@"/app/category/list-with-product"
#define kUrlProduct                     kUrlBase@"/product/view?id=%@"

//查看打折的商品列表
#define kUrlGetFeaturedProducts         kUrlBase@"/product/list-featured-price"
//为你精选的商品列表
#define kUrlGetTopicProducts            kUrlBase@"/product/list-featured-topic"
//销量最高的商品列表
#define kUrlGetTopSaleProducts          kUrlBase@"/product/list-top-seller"

//购物车
#define kUrlGetCart                     kUrlBase@"/cart"
//添加购物车项
#define kUrlCartAdd                     kUrlBase@"/cart/add"
//设置购物车项的数量
#define kUrlSetCartItemCountWithItemId  kUrlBase@"/app/cart/setCartItemNum/%@"
//删除购物车项
#define kUrlCartItemDelete              kUrlBase@"/cart-item/delete?id=%@"
//选取购物车项
#define kUrlSelectCartItemWithItemId    kUrlBase@"/app/cart/setIsSelected/%@"

//从购物车添加预购订单
#define kUrlPreorderAdd                 kUrlBase@"/preorder/create"
//获取预购订单
#define kUrlPreorderWithId              kUrlBase@"/preorder/view?id=%@"
//设置支付方式
#define kUrlPreorderSetPayType          kUrlBase@"/preorder/set-pay-type"

//添加收货地址
#define kUrlAddressAdd                  kUrlBase@"/address/create"
//修改收货地址
#define kUrlAddressEditWithId           kUrlBase@"/address/update?id=%@"
//获得地址列表
#define kUrlAddressGetList              kUrlBase@"/address"
//设置默认地址
#define kUrlAddressSetDefaultWithId     kUrlBase@"/address/set-default?id=%@"
//获得系统默认的区域信息
#define kUrlAreaPrefixChainedAreas      kUrlBase@"/area/find-prefix-area-chained-areas"

//提交订单
#define kUrlOrderAddWithPreorderId      kUrlBase@"/order/create?preorder_id=%@"
//查看订单
#define kUrlOrderViewWithId             kUrlBase@"/order/view?id=%@"
//获取订单列表
#define kUrlOrderList                   kUrlBase@"/order"
//获取待付款订单列表
#define kUrlOrderListPendingPay         kUrlBase@"/order/list-pending-pay"
//获取待收货订单列表
#define kUrlOrderListDelivering         kUrlBase@"/order/list-delivering"
//获取交易完成订单列表
#define kUrlOrderListFinished           kUrlBase@"/order/list-finished"

//获取用户信息
#define kUrlUserGet                     kUrlBase@"/user/view"
//注册 - 提交手机号码
#define kUrlUserRegisterStep1       kUrlBase@"/user/register-step1"
//注册 - 提交手机号码、密码
#define kUrlUserRegisterStep2       kUrlBase@"/user/register-step2"
//注册 - 提交手机号码、密码、验证码
#define kUrlUserRegisterStep3       kUrlBase@"/user/register-step3"
//重置密码 - 提交手机号码
#define kUrlUserForgetPasswordStep1Post kUrlBase@"/app/user/forget-password-step1-post"
//重置密码 - 提交手机号码和密码
#define kUrlUserForgetPasswordStep2Post kUrlBase@"/app/user/forget-password-step2-post"
//重置密码 - 提交手机号码、密码、验证码
#define kUrlUserForgetPasswordStep3Post kUrlBase@"/app/user/forget-password-step3-post"
//登录
#define kUrlUserLogin                   kUrlBase@"/user/login"
//退出登录
#define kUrlUserLogout                  kUrlBase@"/user/logout"


