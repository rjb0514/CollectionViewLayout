//
//  RJBCircleFlowLayout.m
//  自定义布局
//
//  Created by 茹 on 2018/4/5.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBCircleFlowLayout.h"


@interface RJBCircleFlowLayout ()


/**
 布局属性数组
 */
@property (nonatomic, strong) NSMutableArray *attrsArr;

@end

@implementation RJBCircleFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    //先移除
    [self.attrsArr removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        
        [self.attrsArr addObject:attri];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    
    return self.attrsArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //半径
    CGFloat radius = 80;
    CGFloat angle = 2 *M_PI / count * indexPath.item;
    //圆心的位置
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
     attri.size = CGSizeMake(50, 50);
    if (count == 1) {
        attri.center = CGPointMake(oX, oY);
    }else {
        CGFloat centerX = oX + radius * sin(angle) ;
        CGFloat centerY = oY + radius * cos(angle);
        attri.center = CGPointMake(centerX, centerY);
    }
    
    return attri;
}




- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}


@end
