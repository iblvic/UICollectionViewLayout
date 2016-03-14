//
//  SSGiftCollectionViewFlowLayout.h
//  test007
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page;
@end

@interface SSGiftCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) NSUInteger verticalCount;
@property (nonatomic, weak) id<CustomViewFlowLayoutDelegate> delegate;
@end