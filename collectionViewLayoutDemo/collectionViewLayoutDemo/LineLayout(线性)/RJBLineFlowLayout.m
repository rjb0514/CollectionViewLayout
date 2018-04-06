//
//  RJBFlowLayout.m
//  自定义布局
//
//  Created by 茹 on 2018/4/1.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBLineFlowLayout.h"

@implementation RJBLineFlowLayout



//做准备操作 用来做布局的初始化操作 不建议在Init方法操作
- (void)prepareLayout {
    [super prepareLayout];
    //设置内边距
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width)/2.0;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}


/*显示的范围发生改变的时候是否需要重新刷新布局
 1.会调用 prepareLayout
 2.会调用 layoutAttributesForElementsInRect
 
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    
    return YES;
}


//这个方法的返回值 决定colletionView滚动 停止时的 偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.bounds.size;
    
    
    
    NSArray<UICollectionViewLayoutAttributes *> *arr = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView的最中心点的值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2.0;
    NSLog(@"%f",proposedContentOffset.x);
    
    //存放最小的间距
    CGFloat mindate = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attri in arr) {
        
        //cell.中心点 和collectionView中心点的值
        //计算最小值  比较的时候用绝对值  存值得时候用正负值
        if (ABS(mindate) > ABS(attri.center.x - centerX)) {
            mindate = attri.center.x - centerX;
        }
        
    }
    
    //修改原有偏移量
    proposedContentOffset.x += mindate;
    
    return proposedContentOffset;
}



//获取所有的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray<UICollectionViewLayoutAttributes *> *arr = [super layoutAttributesForElementsInRect:rect];
    
    
    //计算collectionView的最中心点的值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0;
    
    
    
    for (UICollectionViewLayoutAttributes *attri in arr) {

        //cell.中心点 和collectionView中心点的值
        CGFloat delta = ABS(attri.center.x - centerX);
        
        CGFloat scale = 1 - delta/self.collectionView.bounds.size.width;
        
        //设置缩放比例
        attri.transform = CGAffineTransformMakeScale(scale, scale);

    }
    
    
    
    
    return arr;
}

@end


/*
 要实现的思路
 1.cell的放大和缩小
 2.cell停止滚动时居中
 
 */
