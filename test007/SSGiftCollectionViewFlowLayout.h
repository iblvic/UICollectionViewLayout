//
//  SSGiftCollectionViewFlowLayout.h
//  test007
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
- (void)numberOfPages:(NSInteger)pages;
@end

@interface SSGiftCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat horizontalMargin;
@property (nonatomic, assign) NSUInteger verticalCount;
@property (nonatomic, weak) id<CustomViewFlowLayoutDelegate> delegate;
@end