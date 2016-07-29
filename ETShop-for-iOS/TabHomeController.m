//
//  TabHomeController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "TabHomeController.h"
#import "ProductController.h"
#import "ProductCategory.h"
#import "Product.h"
#import "TabHomeRightTableCell.h"
#import <CoreLocation/CoreLocation.h>

@interface TabHomeController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
{
    UITableView *_leftTable;
    
    UITableView *_rightTable;
    
    CGFloat _leftTableWidth;
    
    NSInteger _leftTableCurRow; //当前被选中的行
    
    NSArray *_categories;
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}
@end

@implementation TabHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"月光茶人";
    
    _leftTableWidth = 100.f;
    
    _leftTable = [[UITableView alloc] init];
    _leftTable.tableFooterView = [[UIView alloc]init]; //去掉多余的空行分割线
    _leftTable.backgroundColor = [UIColor hexColor:@"ececec"];
    _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTable];
    [_leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(_leftTableWidth);
        make.height.equalTo(self.view);
    }];
    _leftTable.dataSource = self;
    _leftTable.delegate = self;
    _leftTableCurRow = 0;
    
    _rightTable = [[UITableView alloc] init];
    _rightTable.tableFooterView = [[UIView alloc]init]; //去掉多余的空行分割线
    [self.view addSubview:_rightTable];
    [_rightTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftTable.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view).with.offset(64);
        make.height.equalTo(self.view).with.offset(-112);
    }];
    _rightTable.dataSource = self;
    _rightTable.delegate = self;
    
    [self getData];
    
    //启动定位跟踪
    [self startTrackingLocation];
    _geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [weakSelf showLoadingView];
    
    [ProductCategory getCategoriesWithProducts:^(BOOL status, NSNumber *code, NSString *message, NSArray *categories) {
        if (status) {
            _categories = categories;
            [_leftTable reloadData];
            [_rightTable reloadData];
            
            //设置选中leftTable的第一行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_leftTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [weakSelf tableView:_leftTable didSelectRowAtIndexPath:indexPath];
        } else {
            [weakSelf toast:message];
        }
        [weakSelf hideLoadingView];
        [weakSelf hideNetworkBrokenView];
    } failure:^(NSError *error) {
        //网络没有连接
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showNetworkBrokenView:^(MASConstraintMaker *make) {
                make.left.equalTo(_leftTable.mas_right);
                make.right.equalTo(self.view.mas_right);
                make.top.equalTo(self.view).with.offset(64);
                make.height.equalTo(self.view).with.offset(-112);
            }];
        } else {
            [weakSelf toastWithError:error];
        }
        [weakSelf hideLoadingView];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num = 0;
    //leftTable
    if (tableView == _leftTable) {
        num = 1;
    }
    //rightTable
    else if (tableView == _rightTable) {
        num = 1;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    //leftTable
    if (tableView == _leftTable) {
        if (_categories && _categories.count > 0) {
            num = _categories.count;
        }
    }
    //rightTable
    else if (tableView == _rightTable) {
        if (_categories && _categories.count > 0) {
            ProductCategory *category = _categories[_leftTableCurRow];
            num = category.products.count;
        }
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //leftTable
    if (tableView == _leftTable) {
        NSString *identifier = @"leftTableCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor hexColor:@"ececec"];
        }
        ProductCategory *category = _categories[indexPath.row];
        cell.textLabel.text = category.name;
        return cell;
    }
    //rightTable
    else {
        NSString *identifier = @"rightTableCell";
        TabHomeRightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TabHomeRightTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        ProductCategory *category = _categories[_leftTableCurRow];
        Product *product = category.products[indexPath.row];
        [cell fillContentWithProduct:product];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    //leftTable
    if (tableView == _leftTable) {
        height = 50;
    }
    //rightTable
    else if (tableView == _rightTable) {
        height = [TabHomeRightTableCell height];
    }
    return height;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //leftTable，更新rightTable的数据
    if (tableView == _leftTable) {
        _leftTableCurRow = indexPath.row;
        [tableView cellForRowAtIndexPath:indexPath].backgroundColor = kColorWhite;
        [_rightTable reloadData];
    }
    //rightTable
    else if (tableView == _rightTable) {
        ProductCategory *category = _categories[_leftTableCurRow];
        Product *product = category.products[indexPath.row];
        ProductController *productController = [[ProductController alloc] initWithProductId:product.id];
        [self.navigationController pushViewController:productController animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    //leftTable
    if (tableView == _leftTable) {
        [tableView cellForRowAtIndexPath:indexPath].backgroundColor = [UIColor hexColor:@"ececec"];
    }
}

- (void)doClickNetworkBrokenView
{
    [self getData];
}


//启动定位跟踪
- (void)startTrackingLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        //已授权则设置定位参数
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
            || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            _locationManager.delegate = self;
            //设置定位精度
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //定位频率,每隔十米定位一次
            CLLocationDistance distance = 10.0;
            _locationManager.distanceFilter = distance;
            //_locationManager.distanceFilter = kCLDistanceFilterNone;
            //启动跟踪定位
            [_locationManager startUpdatingLocation];
        }
        //如果没有授权则请求用户授权
        else {
            //NSLog(@"请求定位授权");
            [_locationManager requestWhenInUseAuthorization];
        }
    } else {
        //NSLog(@"定位服务未打开");
    }
}

#pragma mark - CLLocationManagerDelegate 代理

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject]; //取出第一个位置
    CLLocationCoordinate2D coordinate = location.coordinate; //位置坐标
    //NSLog(@"经度：%f, 纬度：%f, 海拔：%f, 航向：%f, 行走速度：%f", coordinate.longitude, coordinate.latitude,location.altitude, location.course, location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    //[_locationManager stopUpdatingLocation];
    
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //CLPlacemark *placemark=[placemarks firstObject];
        //NSLog(@"%@", placemark);
        //NSLog(@"详细信息:%@",placemark.addressDictionary);
        //NSLog(@"Name: %@", [placemark.addressDictionary objectForKey:@"Name"]);
        //NSLog(@"City: %@", [placemark.addressDictionary objectForKey:@"City"]);
        //NSLog(@"State: %@", [placemark.addressDictionary objectForKey:@"State"]);
    }];
}

@end
