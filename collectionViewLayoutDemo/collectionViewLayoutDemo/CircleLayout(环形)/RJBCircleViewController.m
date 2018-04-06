//
//  RJBCircleViewController.m
//  collectionViewLayoutDemo
//
//  Created by 茹 on 2018/4/6.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "RJBCircleViewController.h"
#import "RJBCircleFlowLayout.h"

@interface RJBCircleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation RJBCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"环形布局";
    [self.view addSubview:self.collectionView];
    
    
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 11; i++) {
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


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        RJBCircleFlowLayout *layout = [RJBCircleFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

@end
