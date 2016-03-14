//
//  testController.m
//  test007
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import "testController.h"
#import "testBlock.h"

@interface testController ()
{
    BOOL _isGetDataError;
}
@property (nonatomic, strong) testBlock *testObj;
@end

@implementation testController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    self.testObj = [[testBlock alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [_testObj startWith:^(NSString *data, NSError *error) {
        if (error) {
            _isGetDataError = YES;
        } else {
            NSLog(@"%@", data);
        }
    }];
}

- (void)setValue
{

}

- (void)dealloc
{
    NSLog(@"_isGetDataError = %@", _isGetDataError ? @"YES" : @"NO");
}

@end
