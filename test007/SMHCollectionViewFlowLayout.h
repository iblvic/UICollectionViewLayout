//
//  SSGiftCollectionViewFlowLayout.h
//  test007
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMHCollectionViewFlowLayout;
@protocol SMHCollectionViewFlowLayoutDelegate <NSObject>
- (void)flowLayout:(SMHCollectionViewFlowLayout *)layout numberOfPages:(NSInteger)pages;
@end

@interface SMHCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
//@property (nonatomic, assign) CGFloat offsetY;
//@property (nonatomic, assign) CGFloat horizontalMargin;
//@property (nonatomic, assign) NSUInteger verticalCount;
@property (nonatomic, weak) id<SMHCollectionViewFlowLayoutDelegate> delegate;
@end