//
//  RJBWaterLayoutViewController.m
//  collectionViewLayoutDemo
//
//  Created by 茹 on 2018/4/7.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBWaterLayoutViewController.h"
#import "RJBWaterLayout.h"

@interface RJBWaterLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RJBWaterLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation RJBWaterLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"线性布局";
    [self.view addSubview:self.collectionView];
    
    
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 50; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%zd",i]];
        }
    }
    return _dataArr;
}

#pragma mark - data
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    NSInteger tag = 10;
    
    UILabel *name = [cell.contentView viewWithTag:10];
    if (name == nil) {
        name = [[UILabel alloc] init];
        name.textColor = [UIColor blackColor];
        name.tag = tag;
        name.font = [UIFont systemFontOfSize:20];
    }
    name.text = self.dataArr[indexPath.item] ;
    [name sizeToFit];
    [cell.contentView addSubview:name];
    
    
    
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //这两个方法有先后顺序 必须先 删除数据源
    [self.dataArr removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    
}

- (CGFloat)waterLayout:(RJBWaterLayout *)waterLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)width {
    //通过具体的 图片 或者模型 来计算高度
    return 50 + arc4random_uniform(100);
    
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        RJBWaterLayout *layout = [RJBWaterLayout new];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


@end
