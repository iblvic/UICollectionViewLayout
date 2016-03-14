//
//  SSGiftCollectionViewFlowLayout.m
//  test007
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import "SSGiftCollectionViewFlowLayout.h"

#define kCltviewW (self.collectionView.bounds.size.width)
#define kCltviewH (self.collectionView.bounds.size.height)

//#define kPaddingH ((kCltviewW - 3*100)/2)
//#define kPaddingV ((kCltviewH - 4*100 - 64)/3)

@interface SSGiftCollectionViewFlowLayout()
{
    CGFloat horizontalPadding;
    NSUInteger horizontalCount;
    NSUInteger totalItems;
}
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;

@end

@implementation SSGiftCollectionViewFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    
}
//- (id)init {
//    if (self = [super init]) {
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        self.minimumInteritemSpacing = 10.0f;
//        self.sectionInset = UIEdgeInsetsZero;
//        self.itemSize = CGSizeMake(100.f ,100.f);
//        self.minimumLineSpacing = 10.0;
////        self.sectionInset = (UIEdgeInsets){0,0,60,0};
//    }
//    return self;
//}


- (CGSize)collectionViewContentSize
{

    self.dataSource = self.collectionView.dataSource;
    if ([self.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        totalItems = [self.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    }
    NSLog(@"totalItems:%lu",totalItems);
    horizontalCount = kCltviewW/_itemSize.width;
    horizontalPadding = (kCltviewW-horizontalCount*_itemSize.width)/(horizontalCount-1);
    NSUInteger pageCount;
    CGFloat tempCount = totalItems/(horizontalCount*_verticalCount);
    if (tempCount == 0) {
        pageCount = tempCount;
    } else {
        pageCount = (int)tempCount + 1;
    }
    CGFloat contentWidth = self.collectionView.bounds.size.width * pageCount;
    CGSize contentSize = CGSizeMake(contentWidth, 0);

    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
//    NSLog(@"oldBounds:%@,newBounds:%@",NSStringFromCGRect(oldBounds),NSStringFromCGRect(newBounds));
    if (CGRectGetWidth(oldBounds) != CGRectGetWidth(newBounds)) {
        NSLog(@"bounds change!!!");
        return YES;
    } else {
        return NO;
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    NSLog(@"rect:%@",NSStringFromCGRect(rect));
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    NSLog(@"visibleIndexPaths:%@", visibleIndexPaths);
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
//    NSLog(@"layoutAttributes:%@", layoutAttributes);
    
    return layoutAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSUInteger countPerPage = horizontalCount*_verticalCount;
    CGFloat atbX = (horizontalPadding+_itemSize.width)*(indexPath.row%horizontalCount)+(indexPath.row/countPerPage)*kCltviewW;
    CGFloat atbY = (_verticalPadding+_itemSize.height)*(indexPath.row/horizontalCount)- (indexPath.row/countPerPage)*((_verticalPadding+_itemSize.height)*_verticalCount);
    attribute.frame = (CGRect){atbX,atbY,_itemSize};
    return attribute;
}

- (NSArray<NSIndexPath *> *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSUInteger minHorItem = MAX(CGRectGetMinX(rect)/_itemSize.width,0);
    NSLog(@"minx=%f,minHorItem=%lu",CGRectGetMinX(rect),minHorItem);
    NSUInteger maxHorItem = MAX(CGRectGetMaxX(rect)/_itemSize.width,0);
    NSLog(@"maxX=%f,maxHorItem=%lu",CGRectGetMaxX(rect),maxHorItem);
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger idx=minHorItem*_verticalCount; idx < maxHorItem*_verticalCount; idx++) {
        if (idx == totalItems) break;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}


//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"attributes-->before:%@",attributes);
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
//    NSLog(@"visibleRect:%@", NSStringFromCGRect(visibleRect));

    
//    for (UICollectionViewLayoutAttributes *atb in attributes) {
//        NSIndexPath *indexPath = atb.indexPath;
//        CGFloat atbX = (100+kPaddingH)*(indexPath.row%3) + (int)(indexPath.row/12)*kCltviewW;
//        CGFloat atbY = (100+kPaddingV)*(int)(indexPath.row/3) - (int)(indexPath.row/12)*(kCltviewH - 64 + kPaddingV);
//        atb.frame =(CGRect){atbX,atbY,100,100};
//    }
//    NSLog(@"attributes-->after:%@",attributes);
//    int page = (int)(visibleRect.origin.x/visibleRect.size.width + 0.5);
//    NSLog(@"page:%d",page);
//    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:nil page:page];
 
//    for (UICollectionViewLayoutAttributes *attribute in attributes) {
//        if (CGRectIntersectsRect(attribute.frame, rect)) {
////            NSLog(@"-:%@", attribute);
//            if (visibleRect.origin.x == 0) {
//                [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:0];
//            }else{
//                // 除法取整 取余数
//                div_t x = div(visibleRect.origin.x,visibleRect.size.width);
//                if (x.quot > 0 && x.rem > 0) {
//                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:x.quot + 1];
//                }
//                if (x.quot > 0 && x.rem == 0) {
//                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:x.quot];
//                }
//            }
//        }
//    }
 
//    return attributes;
//}

@end
