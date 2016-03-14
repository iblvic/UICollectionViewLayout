//
//  testBlock.h
//  test007
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Myblock)(NSString *data, NSError *error);

@interface testBlock : NSObject
- (void)startWith:(Myblock)block;
@end
