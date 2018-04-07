//
//  RJBGridLayout.m
//  自定义布局
//
//  Created by 茹 on 2018/4/5.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBGridLayout.h"

@interface RJBGridLayout ()

@property (nonatomic, strong) NSMutableArray *attrsArr;

@end




/**
 继承于 UICollectionViewLayout   自定义的layout 要实现以下4个方法
 */


@implementation RJBGridLayout



/**
 1. 实现的第一个方法
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    NSLog(@"%s",__func__);
    // 注意： 清楚之前的所有属性
    [self.attrsArr removeAllObjects];
    
    
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        
        [self.attrsArr addObject:attri];
    }
    
}

/**
 2. 实现的第2个方法
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
        NSLog(@"%s",__func__);
    
    return self.attrsArr;
}




/**
 继承自UICollectionViewLayout 的自定义布局要实现 下面这个方法 要不在切换布局的时候 会错换

 @param indexPath indexPath
 @return UICollectionViewLayoutAttributes
 */

/**
 3. 实现的第3个方法
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
        NSLog(@"%s",__func__);
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    //计算frame
    CGFloat width = self.collectionView.frame.size.width * 0.5;
    
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSInteger num = indexPath.item / 3;
    if (indexPath.item  % 3 == 0) {
        height = width;
        x = 0;
        y = 0 + height * num;
        
    }else if (indexPath.item  % 3 == 1) {
        height = width * 0.5;
        x = width ;
        y = 0 + height * 2 * num;
        
    }else if (indexPath.item  % 3 == 2) {
        height = width * 0.5;
        x = width ;
        y = height + height * 2 * num;
    }
    attri.frame = CGRectMake(x, y, width, height);
    
    return attri;
}




- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}



/**
 4. 实现的第4个方法
 */

//以为继承的是UICollectionViewLayout
#pragma mark - 重新这个方法 返回滚动内容的大小 否则不会滚动
- (CGSize)collectionViewContentSize {
    
        NSLog(@"%s",__func__);
    
    //算出有多少行
    NSInteger row = (self.attrsArr.count + 2 ) / 3;
    //一行的高度
    CGFloat width = self.collectionView.frame.size.width * 0.5;
    
    return CGSizeMake(0, row * width);
}


@end
