//
//  RJBWaterLayout.h
//  collectionViewLayoutDemo
//
//  Created by 茹 on 2018/4/7.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJBWaterLayout;
@protocol RJBWaterLayoutDelegate <NSObject>

@required

/**
 给外界调用 告诉 Item的高度是多少

 @param waterLayout 水流
 @param index Index
 @param width item的宽度
 @return 高度
 */
- (CGFloat)waterLayout:(RJBWaterLayout *)waterLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)width;

@optional

/**
 行间距
 */
- (CGFloat)rowMarginInWaterLayout:(RJBWaterLayout *)waterLayout;
/**
 列间距
 */
- (CGFloat)colunmMarginInWaterLayout:(RJBWaterLayout *)waterLayout;
/**
 列数
 */
- (NSUInteger)columnCountInWaterLayout:(RJBWaterLayout *)waterLayout;
/**
边缘间距
 */
- (UIEdgeInsets)edgeInsetInWaterLayout:(RJBWaterLayout *)waterLayout;

@end

@interface RJBWaterLayout : UICollectionViewLayout


/**
 代理
 */
@property (nonatomic, weak) id<RJBWaterLayoutDelegate> delegate;


@end
