//
//  RJBWaterLayout.m
//  collectionViewLayoutDemo
//
//  Created by 茹 on 2018/4/7.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBWaterLayout.h"


//默认是3列
static const NSUInteger RJBDefaultColumnCount = 3;
//默认行间距
static const CGFloat RJBDefaultRowMargin = 10;
//默认列间距
static const CGFloat RJBDefaultColunmMargin = 10;
//边缘间距
static const UIEdgeInsets RJBDefaultEdgeInset = {10,10,10,10};

@interface RJBWaterLayout ()



/**
 每个celll的属性 数组
 */
@property (nonatomic, strong) NSMutableArray *attrsArr;

/** 高度数组 */
@property (nonatomic, strong) NSMutableArray *heigthArr;

- (UIEdgeInsets)rjb_edgeInset;
- (CGFloat)rjb_rowMargin;
- (CGFloat)rjb_columnMargin;
- (NSUInteger)rjb_colunmCount;

@end

@implementation RJBWaterLayout



/**
 1. 实现的第一个方法
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化高度数组
    [self.heigthArr removeAllObjects];
    for (NSInteger i = 0; i < self.rjb_colunmCount; i++) {
        [self.heigthArr addObject:@(self.rjb_edgeInset.top)];
    }
    
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
    CGFloat width = (self.collectionView.frame.size.width - self.rjb_edgeInset.left - self.rjb_edgeInset.right - self.rjb_columnMargin * (self.rjb_colunmCount - 1)) / self.rjb_colunmCount;
    
    //通过外界传的高度
    CGFloat height = [self.delegate waterLayout:self heightForItemAtIndex:indexPath.item itemWidth:width];
 
    
    //找出最短的那列 和对应的数组
    __block CGFloat minHight = CGFLOAT_MAX;
    __block NSUInteger column = 0; //第几列
    [self.heigthArr enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (minHight > obj.doubleValue) {
            minHight = obj.doubleValue;
            column = idx;
        }
    }];
    
    CGFloat x = RJBDefaultEdgeInset.left +  (width + RJBDefaultColunmMargin) * column ;
    CGFloat y = minHight;
    //防止top 和Margin 不一样
    if (minHight != self.rjb_edgeInset.top) {
      y = minHight + self.rjb_rowMargin;
    }
    attri.frame = CGRectMake(x, y, width, height);
    
    //更新对应列的高度
    self.heigthArr[column] = @(CGRectGetMaxY(attri.frame));
    

    
    return attri;
}




- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

- (NSMutableArray *)heigthArr {
    if (!_heigthArr) {
        _heigthArr = [NSMutableArray array];
    }
    return _heigthArr;
}


/**
 4. 实现的第4个方法
 */

//以为继承的是UICollectionViewLayout
#pragma mark - 重新这个方法 返回滚动内容的大小 否则不会滚动
- (CGSize)collectionViewContentSize {
    
    NSLog(@"%s",__func__);
    
    //找出最短的那列 和对应的数组
    __block CGFloat maxHeight = 0;
    __block NSUInteger column = 0; //第几列
    [self.heigthArr enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (maxHeight < obj.doubleValue) {
            maxHeight = obj.doubleValue;
            column = idx;
        }
    }];
    
    
    
    return CGSizeMake(0, maxHeight);
}


#pragma mark - 代理方法的处理
//行间距
- (CGFloat)rjb_rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterLayout:)]) {
        return [self.delegate rowMarginInWaterLayout:self];
    }else{
        return RJBDefaultRowMargin;
    }
}

//列间距
- (CGFloat)rjb_columnMargin{
    if ([self.delegate respondsToSelector:@selector(colunmMarginInWaterLayout:)]) {
        return [self.delegate colunmMarginInWaterLayout:self];
    }else{
        return RJBDefaultColunmMargin;
    }
}

//行数
- (NSUInteger)rjb_colunmCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterLayout:)]) {
      return   [self.delegate columnCountInWaterLayout:self];
    }else {
        return RJBDefaultColumnCount;
    }
}

//边缘间距
- (UIEdgeInsets)rjb_edgeInset {
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterLayout:)]) {
      return  [self.delegate edgeInsetInWaterLayout:self];
    }else {
        return RJBDefaultEdgeInset;
    }
}


@end
