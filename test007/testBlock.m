//
//  testBlock.m
//  test007
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import "testBlock.h"

@interface testBlock()
@property (nonatomic, copy) Myblock block;
@end

@implementation testBlock
- (void)startWith:(Myblock)block
{
    _block = block;
    
    [self performSelector:@selector(blockAction) withObject:nil afterDelay:1];
}

- (void)blockAction
{
    if (_block) {
        
        _block(@"data", nil);
    }
}
@end
