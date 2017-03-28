//
//  PickPlaceMenu.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PickPlaceMenu.h"

@interface PickPlaceMenu ()

@property (nonatomic, strong) UIButton * btn_province;
@property (nonatomic, strong) UIButton * btn_city;
@property (nonatomic, strong) UIButton * btn_district;
@property (nonatomic, strong) UILabel * lab_lineV1;
@property (nonatomic, strong) UILabel * lab_lineV2;
@property (nonatomic, strong) UILabel * lab_lineH;
@end

@implementation PickPlaceMenu

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
    }
    return self;
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.btn_province];
    [self addSubview:self.btn_city];
    [self addSubview:self.btn_district];
    [self addSubview:self.lab_lineV1];
    [self addSubview:self.lab_lineV2];
    [self addSubview:self.lab_lineH];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float width = self.bounds.size.width;
    [_btn_province mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@((width - 2)/3));
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.left.mas_equalTo(@0);
    }];
    
    [_lab_lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(@5);
        make.bottom.mas_equalTo(@-6);
        make.left.mas_equalTo(_btn_province.mas_right);
    }];
    
    [_btn_city mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@((width - 2)/3));
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.left.mas_equalTo(_lab_lineV1.mas_right);
    }];
    
    [_lab_lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(@5);
        make.bottom.mas_equalTo(@-6);
        make.left.mas_equalTo(_btn_city.mas_right);
    }];
    
    [_btn_district mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@((width - 2)/3));
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@-1);
        make.left.mas_equalTo(_lab_lineV2.mas_right);
    }];
    
    [_lab_lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 1));
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
    }];
}

#pragma mark - config view

- (void)configViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district {
    
    if (province) {
        
        [_btn_province setTitle:province forState:UIControlStateNormal];
    }
    
    if (city) {
        
        [_btn_city setTitle:city forState:UIControlStateNormal];
    }
    
    if (district) {
        
        [_btn_district setTitle:district forState:UIControlStateNormal];
    }
}

- (void)reset {
    
    if (_btn_province.selected) {
        
        _btn_province.selected = NO;
    }
    
    if (_btn_city.selected) {
        
        _btn_city.selected = NO;
    }
    
    if (_btn_district.selected) {
        
        _btn_district.selected = NO;
    }
}

#pragma mark - button event

- (void)clickSelectProvince:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_city.selected = NO;
    _btn_district.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        
        [self.delegate menuView:self didSelectAtIndex:0 isShow:sender.selected];
    }
}

- (void)clickSelectCity:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_province.selected = NO;
    _btn_district.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        
        [self.delegate menuView:self didSelectAtIndex:1 isShow:sender.selected];
    }
}

- (void)clickSelectDistrict:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_province.selected = NO;
    _btn_city.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:isShow:)]) {
        
        [self.delegate menuView:self didSelectAtIndex:2 isShow:sender.selected];
    }
}

#pragma mark - setter and getter

- (UIButton *)btn_province {
    
    if (!_btn_province) {
        
        _btn_province = [[UIButton alloc] init];
        _btn_province.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn_province setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_province setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_btn_province addTarget:self action:@selector(clickSelectProvince:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_province;
}

- (UIButton *)btn_city {
    
    if (!_btn_city) {
        
        _btn_city = [[UIButton alloc] init];
        _btn_city.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn_city setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_city setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_btn_city addTarget:self action:@selector(clickSelectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_city;
}

- (UIButton *)btn_district {
    
    if (!_btn_district) {
        
        _btn_district = [[UIButton alloc] init];
        _btn_district.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn_district setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_district setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_btn_district addTarget:self action:@selector(clickSelectDistrict:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_district;
}

- (UILabel *)lab_lineV1 {
    
    if (!_lab_lineV1) {
        
        _lab_lineV1 = [[UILabel alloc] init];
        _lab_lineV1.backgroundColor = Color_Line;
    }
    return _lab_lineV1;
}

- (UILabel *)lab_lineV2 {
    
    if (!_lab_lineV2) {
        
        _lab_lineV2 = [[UILabel alloc] init];
        _lab_lineV2.backgroundColor = Color_Line;
    }
    return _lab_lineV2;
}

- (UILabel *)lab_lineH {
    
    if (!_lab_lineH) {
        
        _lab_lineH = [[UILabel alloc] init];
        _lab_lineH.backgroundColor = Color_Line;
    }
    return _lab_lineH;
}


@end
