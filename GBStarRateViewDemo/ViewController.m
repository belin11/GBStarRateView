//
//  ViewController.m
//  GBStarRateViewDemo
//
//  Created by midas on 2018/7/19.
//  Copyright © 2018年 Midas. All rights reserved.
//

#import "ViewController.h"
#import "GBStarRateView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, GBStarRateViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"全星评分",@"半星评分",@"不完整星评分",@"设置星星个数",@"设置星星间隔",@"设置星星尺寸大小",@"设置星星分数",@"自定义星星"];
    [self.view addSubview:self.tableView];
}

- (void)starRateView:(GBStarRateView *)starRateView didSelecteStarAtStarRate:(CGFloat)starRate {
    
    NSLog(@"starRate=%0.1f", starRate);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleWholeStar;
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 1:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10) style:GBStarRateViewStyleHalfStar numberOfStars:5 isAnimation:YES delegate:self];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleHalfStar;
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 2:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleIncompleteStar;
            starRateView.delegate = self;
            starRateView.allowSlideScore = YES;
            
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 3:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleIncompleteStar;
            starRateView.numberOfStars = 6;
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 4:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleWholeStar;
            starRateView.spacingBetweenStars = 5;
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 5:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleWholeStar;
            starRateView.starSize = CGSizeMake(30, 30);
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
        case 6:{
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 10)];
            [cell.contentView addSubview:starRateView];
            starRateView.numberOfStars = 5;
            starRateView.style = GBStarRateViewStyleIncompleteStar;
            starRateView.allowSlideScore = YES;
            starRateView.currentStarRate = 1.5;
            cell.textLabel.text = self.titles[indexPath.row];
            break;
        };
            
        case 7:{
            
            GBStarRateView *starRateView = [[GBStarRateView alloc] initWithFrame:CGRectMake(150, 30, 200, 15) style:GBStarRateViewStyleHalfStar numberOfStars:6 isAnimation:YES finish:^(GBStarRateView *starRateView, CGFloat starRate) {
                NSLog(@"startRate: %f", starRate);
            }];
            [cell.contentView addSubview:starRateView];
            cell.textLabel.text = self.titles[indexPath.row];

            break;
        }
    }
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


@end
