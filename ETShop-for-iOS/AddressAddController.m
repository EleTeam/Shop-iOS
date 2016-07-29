//
//  AddressAddController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressAddController.h"
#import "AddressListController.h"
#import "AddressAddView.h"
#import "AddressModel.h"
#import "AreaModel.h"
#import "ValidatorUtil.h"

@interface AddressAddController () <AddressAddViewDelegate>
{
    AddressAddView *_vView;
}
@end

@implementation AddressAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加收货地址";
    
    _vView = [[AddressAddView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+kNavBarHeight, kScreenWidth, kScreenHeight)];
    _vView.delegate = self;
    
    [self getData];
    [self.view addSubview:_vView];
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    [AreaModel getPrefixChainedAreas:^(BOOL result, NSNumber *resultCode, NSString *message, AreaEntity *area, NSArray *chainedAreas) {
        if (result) {
            [_vView setChainedAreas:chainedAreas];
        } else {
            [weakSelf toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

#pragma mark - AddressAddViewDelegate

- (void)doClickSaveBtnWithAreaId:(NSString *)areaId
                       telephone:(NSString *)telephone
                          detail:(NSString *)detail
                        fullname:(NSString *)fullname
{
    if (fullname.length <= 0) {
        [self toast:@"收货人姓名不能为空"];
        return;
    }
    
    NSError *error = nil;
    if (![ValidatorUtil isValidMobile:telephone error:&error]) {
        [self toast:error.localizedDescription];
        return;
    }
    
    if (areaId.length <= 0) {
        [self toast:@"请选择街区"];
        return;
    }
    
    if (detail.length <= 0) {
        [self toast:@"详细地址不能为空"];
        return;
    }
    
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    [AddressModel addWithAreaId:areaId
                      telephone:telephone
                         detail:detail
                       fullname:fullname
                        success:^(BOOL result, NSNumber *resultCode, NSString *message, AddressEntity *address, NSArray *addresses) {
                            if (result) {
                                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:address forKey:@"address"];
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyPreorderAddressDidChanged object:nil userInfo:userInfo];
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyPreorderAddressesDidChanged object:nil userInfo:userInfo];
                                //返回到前两个控制器
                                NSInteger ctrlCount = self.navigationController.viewControllers.count;
                                NSInteger indexCount = 0;
                                if (ctrlCount >= 3) {
                                    indexCount = ctrlCount - 3;
                                }
                                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:indexCount] animated:YES];
                            } else {
                                [weakSelf toast:message];
                                [weakSelf hideLoadingView];
                            }
                        } failure:^(NSError *error) {
                            [weakSelf toastWithError:error];
                            [weakSelf hideLoadingView];
                        }];
}

@end
