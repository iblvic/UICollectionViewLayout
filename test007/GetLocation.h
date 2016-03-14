//
//  GetLocation.h
//  CustomMy51c
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 yuanx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^GetLocationBlock)(double latitude, double longitude);

@interface GetLocation : NSObject

- (void)startGetLocation:(GetLocationBlock) block;

@end
