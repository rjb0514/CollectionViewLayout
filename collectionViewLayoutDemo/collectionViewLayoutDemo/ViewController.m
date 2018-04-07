//
//  ViewController.m
//  collectionViewLayoutDemo
//
//  Created by 茹 on 2018/4/6.
//  Copyright © 2018年 kkx. All rights reserved.
//

#import "ViewController.h"
#import "RJBLineLayoutVCViewController.h"
#import "RJBCircleViewController.h"
#import "RJBGridViewController.h"
#import "ChangeViewController.h"
#import "RJBWaterLayoutViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"线性布局",@"环形布局",@"格子布局",@"瀑布流",@"组合切换"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"布局的demo";
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        //线性布局
        RJBLineLayoutVCViewController *VC  = [RJBLineLayoutVCViewController new];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.row == 1) {
        //环形
        RJBCircleViewController *VC = [RJBCircleViewController new];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.row == 2) {
        //格子
        RJBGridViewController *VC = [RJBGridViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 3) {
        RJBWaterLayoutViewController *VC = [RJBWaterLayoutViewController new];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else {
        //多个布局切换
        ChangeViewController *VC = [ChangeViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"table"];
    }
    return _tableView;
}


@end
