//
//  SMHCollectionViewCell.m
//  test007
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import "SMHCollectionViewCell.h"

@implementation SMHCollectionViewCell

- (UILabel *)title
{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.bounds = (CGRect){0,0,100,30};
        _title.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_title];
    }
    
    return _title;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.title.center = self.contentView.center;
    CGFloat containW = self.contentView.bounds.size.width;
    self.title.bounds = (CGRect){0,0,containW,30};
}

@end
