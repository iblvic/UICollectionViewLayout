//
//  SSGiftCollectionViewFlowLayout.m
//  test007
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 com.benmai. All rights reserved.
//

#import "SMHCollectionViewFlowLayout.h"

#define kCltviewW (self.collectionView.bounds.size.width)
#define kCltviewH (self.collectionView.bounds.size.height)


@interface SMHCollectionViewFlowLayout()
{
    CGFloat    _horizontalPadding;
    NSUInteger _horizontalCount;
    NSUInteger _verticalCount;
    NSUInteger _totalItems;
    NSUInteger _pageCount;
}
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;

@end

@implementation SMHCollectionViewFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    self.dataSource = self.collectionView.dataSource;
    if ([self.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        _totalItems = [self.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    }
    NSLog(@"totalItems:%lu",_totalItems);
    _horizontalCount = (kCltviewW - _sectionInset.left - _sectionInset.right) / _itemSize.width;
    _horizontalPadding = (kCltviewW - _horizontalCount * _itemSize.width- _sectionInset.left - _sectionInset.right) / (_horizontalCount-1);
    _verticalCount = (kCltviewH - _sectionInset.top - _sectionInset.bottom - 64 + _verticalPadding) / (_itemSize.height + _verticalPadding);
    NSUInteger pageCount;
    NSUInteger tempCount = (NSUInteger)(_totalItems/(_horizontalCount*_verticalCount));
    if ((_totalItems % (_horizontalCount * _verticalCount)) == 0) {
        pageCount = tempCount;
    } else {
        pageCount = tempCount + 1;
    }
    if ([self.delegate respondsToSelector:@selector(flowLayout:numberOfPages:)]) {
        [self.delegate flowLayout:self numberOfPages:pageCount];
    }
    _pageCount = pageCount;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionInset = (UIEdgeInsets){10,10,10,10};
        self.itemSize = (CGSize){100, 120};
        self.verticalPadding = 15;
    }
    return self;
}


- (CGSize)collectionViewContentSize
{
    NSLog(@"---collectionViewContentSize---");
    return (CGSize){kCltviewW * _pageCount,0};
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
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
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    return layoutAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSUInteger countPerPage = _horizontalCount*_verticalCount;
    CGFloat atbX = _sectionInset.left + (_horizontalPadding+_itemSize.width) * (indexPath.row % _horizontalCount) + (indexPath.row / countPerPage) * kCltviewW;
    CGFloat atbY = _sectionInset.top + (_verticalPadding + _itemSize.height) * (indexPath.row / _horizontalCount) - (indexPath.row / countPerPage) * ((_verticalPadding + _itemSize.height) * _verticalCount);
    attribute.frame = (CGRect){atbX,atbY,_itemSize};
    return attribute;
}

- (NSArray<NSIndexPath *> *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSUInteger minPage = MAX(CGRectGetMinX(rect),0) / kCltviewW;
    NSUInteger maxPage = MAX(CGRectGetMaxX(rect),0) / kCltviewW + 0.5;
    NSLog(@"rect--%@", NSStringFromCGRect(rect));
    NSLog(@"minPage:%@--maxPage:%@", @(minPage), @(maxPage));
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger itemsPerPage = _verticalCount * _horizontalCount;
    for (NSUInteger page = minPage; page < maxPage; page++) {
        for (NSUInteger i = 0; i < itemsPerPage; i++) {
            NSUInteger idx = (page * itemsPerPage) + i;
            if (idx >= _totalItems) return indexPaths;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }
    NSLog(@"indexPath:%@", indexPaths);
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
