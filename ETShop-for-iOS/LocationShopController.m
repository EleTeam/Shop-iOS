//
//  LocationShopController.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 16/3/15.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "LocationShopController.h"
#import "LocationAnnotationModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface LocationShopController () <MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}
@end


@implementation LocationShopController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"店址导航";
    
    [self initGUI];
}

#pragma mark 添加地图控件
- (void)initGUI
{
    //请求定位服务
    _locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled]
        || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    _mapView = [[MKMapView alloc] initWithFrame:rect];
    _mapView.delegate = self;
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    
    //添加大头针
    [self addAnnotation];
    
    [self.view addSubview:_mapView];
}

#pragma mark 添加大头针
-(void)addAnnotation{
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(22.64951300, 113.82572800);
    LocationAnnotationModel *annotation1=[[LocationAnnotationModel alloc]init];
    annotation1.title=@"月光茶人(下十围店)";
    annotation1.subtitle=@"深圳市宝安区福永镇东福围东街103-5号";
    annotation1.coordinate=location1;
    [_mapView addAnnotation:annotation1];
    
    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(22.63746900,+113.83181500);
    LocationAnnotationModel *annotation2=[[LocationAnnotationModel alloc]init];
    annotation2.title=@"月光茶人(兴围店)";
    annotation2.subtitle=@"深圳市宝安区福永镇兴围大道1号(深鹏百货旁)";
    annotation2.coordinate=location2;
    [_mapView addAnnotation:annotation2];
    
    //[self getCoordinateByAddress:@"深鹏百货"]; //用做测试获取坐标
}

#pragma mark - MKMapViewDelegate 地图控件代理方法
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    //    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    //    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //    [_mapView setRegion:region animated:true];
}

#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        for (CLPlacemark *placemark in placemarks) {
            CLLocation *location = placemark.location;//位置
            CLRegion *region = placemark.region;//区域
            NSDictionary *addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
            //        NSString *name=placemark.name;//地名
            //        NSString *thoroughfare=placemark.thoroughfare;//街道
            //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
            //        NSString *locality=placemark.locality; // 城市
            //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
            //        NSString *administrativeArea=placemark.administrativeArea; // 州
            //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
            //        NSString *postalCode=placemark.postalCode; //邮编
            //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
            //        NSString *country=placemark.country; //国家
            //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
            //        NSString *ocean=placemark.ocean; // 海洋
            //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
            //NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
            NSLog(@"Name: %@", [addressDic objectForKey:@"Name"]);
            NSLog(@"Location: %@", location);
            NSLog(@"Region: %@", region);
        }
    }];
}

@end
