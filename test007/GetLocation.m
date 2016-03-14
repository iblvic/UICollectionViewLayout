//
//  GetLocation.m
//  CustomMy51c
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 yuanx. All rights reserved.
//

#import "GetLocation.h"

#import "WGS84TOGCJ02.h"

#import "CLLocation+Translate.h"

@interface GetLocation() <CLLocationManagerDelegate>

@property (nonatomic, copy) GetLocationBlock block;

@property (nonatomic ,strong) CLLocationManager *mgr;

@end

@implementation GetLocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mgr.delegate = self;
        
        self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 判断是否是iOS8
        if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
        {
            NSLog(@"是iOS8");
            // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
            [self.mgr requestWhenInUseAuthorization]; // 请求前台和后台定位权限
        }
        
        [self.mgr startUpdatingLocation];
        
    }
    return self;
}


/**
 *  授权状态发生改变时调用
 *
 *  @param manager 触发事件的对象
 *  @param status  当前授权的状态
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        
        NSLog(@"等待用户授权");
        
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse)
        
    {
        NSLog(@"授权成功");
        
        [self.mgr startUpdatingLocation];
        
    }else
    {
        NSLog(@"授权失败");
    }
}

#pragma mark - CLLocationManagerDelegate
/**
 *  获取到位置信息之后就会调用(调用频率非常高)
 *
 *  @param manager   触发事件的对象
 *  @param locations 获取到的位置
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = [locations lastObject];
    
    NSLog(@"%f, %f speed ==>> %f", location.coordinate.latitude , location.coordinate.longitude, location.speed);
    

    
    if(_block) {
        
        /*
        if (![WGS84TOGCJ02 isLocationOutOfChina:[location coordinate]]) {
            //转换后的coord
            CLLocationCoordinate2D coord = [WGS84TOGCJ02 transformFromWGSToGCJ:[location coordinate]];
            
            _block(coord.latitude, coord.longitude);
            
        } else {
            
            _block(location.coordinate.latitude, location.coordinate.longitude);
        }
        */
        
        CLLocation *locationT = [location locationMarsFromEarth];
        
        _block(locationT.coordinate.latitude, locationT.coordinate.longitude);
        
        
//        [self.mgr stopUpdatingLocation];
    }
    
    
}

- (void)startGetLocation:(GetLocationBlock)block
{
    _block = block;
    
    [self.mgr startUpdatingLocation];
}

- (void)dealloc
{
    [self.mgr stopUpdatingLocation];
}

#pragma mark - 懒加载
- (CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}


@end
