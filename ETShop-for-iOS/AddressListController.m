//
//  AddressListController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressListController.h"
#import "AddressAddController.h"
#import "AddressEditController.h"
#import "AddressListCell.h"
#import "AddressListEmptyCell.h"
#import "AddressAddBtn.h"
#import "Area.h"
#import "Address.h"

@interface AddressListController () <UITableViewDataSource, UITableViewDelegate, AddressAddBtnDelegate, AddressListCellDelegate>
{
    UITableView *_vTable;
    AddressAddBtn *_vAddressAddBtn;
    NSMutableArray *_addresses; //添加和删除收货地址时会改变个数
}

@end

@implementation AddressListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    
    CGFloat addressAddBtnHeight = 44;
    CGFloat tableHeight = kScreenHeight - addressAddBtnHeight;
    
    _vTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - addressAddBtnHeight)];
    //_vTable.fd_debugLogEnabled = YES;
    _vTable.dataSource = self;
    _vTable.delegate = self;
    
    _vAddressAddBtn = [[AddressAddBtn alloc] initWithFrame:CGRectMake(0, tableHeight, kScreenWidth, addressAddBtnHeight)];
    _vAddressAddBtn.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addAddress:)
                                                 name:kNotifyPreorderAddressesDidChanged
                                               object:nil];
    
    [self.view addSubview:_vTable];
    [self.view addSubview:_vAddressAddBtn];
    [self getData];
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    [Address getAddresses:^(BOOL status, NSNumber *code, NSString *message, NSArray *addresses) {
        if (status) {
            _addresses = [addresses mutableCopy];
            [_vTable reloadData];
            
        } else {
            [weakSelf toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_addresses.count > 0) {
        return _addresses.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    if (_addresses.count > 0) {
        identifier = @"AddressListCell";
        AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        Address *address = _addresses[indexPath.row];
        [cell fillContentWithAddress:address];
        return cell;
    }
    else {
        identifier = @"AddressListEmptyCell";
        AddressListEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AddressListEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.delegate = self;
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView registerClass:[AddressListCell class] forCellReuseIdentifier:@"AddressListCell"];
//    if (_addresses.count > 0) {
//        return [tableView fd_heightForCellWithIdentifier:@"AddressListCell" configuration:^(AddressListCell *cell) {
//            cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//            AddressEntity *address = _addresses[indexPath.row];
//            [cell fillContentWithAddress:address];
//        }];
//    }
    return [AddressListCell height];
}

#pragma mark - AddressListEmptyCellDelegate

- (void)doClickAddressAddBtn
{
    AddressAddController *ctrl = [[AddressAddController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - AddressListCellDelegate

-(void)doSelectAddress:(Address *)address
{
    [Address setDefaultWithId:address.id
                           success:^(BOOL status, NSNumber *code, NSString *message, Address *address, NSArray *addresses) {
                               //
                           } failure:^(NSError *error) {
                               //
                           }];
    
    NSDictionary *info = [NSDictionary dictionaryWithObject:address forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyPreorderAddressDidChanged object:nil userInfo:info];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//响应通知中心的方法
- (void)addAddress:(NSNotification *)notification
{
    Address *address = [[notification userInfo] objectForKey:@"address"];
    [_addresses addObject:address];
    [_vTable reloadData];
}

@end
