//
//  ViewController.m
//  test007
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 com.benmai. All rights reserved.
//

#import "ViewController.h"
#import "SSGiftCollectionViewFlowLayout.h"
#import "SMHCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, CustomViewFlowLayoutDelegate>
@property (nonatomic, strong) UICollectionView *cltView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

static NSString *identifier = @"collectionCell";

@implementation ViewController

- (UICollectionView *)cltView{
    if (_cltView != nil) {
        return _cltView;
    }
    SSGiftCollectionViewFlowLayout *viewFlowLayout = [[SSGiftCollectionViewFlowLayout alloc] init];
    viewFlowLayout.verticalCount = 3;
    viewFlowLayout.itemSize = (CGSize){100,120};
    viewFlowLayout.horizontalMargin = 20/3;
    viewFlowLayout.offsetY = 10;
    viewFlowLayout.verticalPadding = 10;
    viewFlowLayout.delegate = self;
    _cltView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:viewFlowLayout];
    _cltView.showsHorizontalScrollIndicator = FALSE; // 去掉滚动条
    _cltView.alwaysBounceHorizontal = YES;
    _cltView.pagingEnabled = YES;
    _cltView.scrollEnabled = YES;
    _cltView.delegate = self;
    _cltView.dataSource = self;
    [_cltView registerClass:[SMHCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    return _cltView;
}
#pragma mark - 实现CustomViewFlowLayoutDelegate
//- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page{
//    self.pageControl.currentPage = page; // 分页控制器当前显示的页数
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cltView.frame = self.view.bounds;
    [self.view addSubview:_cltView];
    
    UIPageControl *pageCtl = [[UIPageControl alloc] init];
    pageCtl.center = (CGPoint){self.view.center.x, self.view.bounds.size.height - 30};
    pageCtl.numberOfPages = 5;
    [self.view addSubview:pageCtl];
    self.pageControl = pageCtl;
    
}
- (void)numberOfPages:(NSInteger)pages
{
    self.pageControl.numberOfPages = pages;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 28;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.title.text = [NSString stringWithFormat:@"item-%d",indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row---%ld", (long)indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    self.pageControl.currentPage = currentPage;
}

@end
