//
//  PickPlaceView.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PickPlaceView.h"

#define Cell_Place    @"Cell_Place"
@interface PickPlaceView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) float kWidth;
@property (nonatomic, assign) float kHeight;
@end
@implementation PickPlaceView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
    }
    return self;
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.tableView];
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _kWidth = self.bounds.size.width;
    _kHeight = self.bounds.size.height;
}

#pragma mark - public method

- (void)reloadViewWithData:(NSArray *)dataArr component:(NSInteger)component {
    
    _index = component;
    self.dataArr = [NSMutableArray arrayWithArray:dataArr];
    
    float height = self.dataArr.count * 44;
    if (_kHeight - height > 0) {
        
        _tableView.frame = CGRectMake(0, -height, _kWidth, height);
    } else {
        
        _tableView.frame = CGRectMake(0, -_kHeight, _kWidth, _kHeight);
    }
    [_tableView reloadData];
    
    [self show];
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(placeViewDidHide)]) {
        
        [self.delegate placeViewDidHide];
    }
    [self hide];
}

#pragma mark - tableView dataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell_Place forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArr.count) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = _dataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * place = self.dataArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(placeView:didSelectPlace:atComponent:atRow:)]) {
        
        [self.delegate placeView:self didSelectPlace:place atComponent:_index atRow:indexPath.row];
    }
    [self hide];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float offset = scrollView.contentOffset.y;
    
    if (offset <= 0) {
        
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - private method

- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0.3);
        _tableView.frame = CGRectMake(0, 0, _kWidth, _tableView.bounds.size.height);
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0);
        _tableView.frame = CGRectMake(0, -_kHeight, _kWidth, _kHeight);
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell_Place];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}


@end
