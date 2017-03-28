//
//  ViewController.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "ViewController.h"
#import "PickPlace.h"

@interface ViewController () <PickPlaceMenuDelegate, PickPlaceViewDelegate>

@property (nonatomic, strong) PickPlaceMenu * view_menu;
@property (nonatomic, strong) PickPlaceView * view_place;

@property (nonatomic, strong) NSMutableArray * placeArr;

@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger districtIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"地区选择";
    
    [self loadData];
    [self addSubviews];
    [self makeConstraintsForUI];
}

#pragma mark - load data

- (void)loadData {
    
    _provinceIndex = 0;
    _cityIndex = 0;
    _districtIndex = 0;
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Place" ofType:@"plist"]];
    NSLog(@"%@", dic);
    NSArray * provinceArr = dic[@"province"];
    
    for (int i = 0; i < provinceArr.count; i++) {
        
        NSDictionary * provinceDic = provinceArr[i];
        Province * province = [[Province alloc] init];
        province.province = provinceDic[@"province"];
        
        NSArray * cityArr = provinceDic[@"city"];
        for (int j = 0; j < cityArr.count; j++) {
            
            NSDictionary * cityDic = cityArr[j];
            City * city = [[City alloc] init];
            city.city = cityDic[@"city"];
            
            NSArray * districtArr = cityDic[@"district"];
            for (int k = 0; k < districtArr.count; k++) {
                
                District * district = [[District alloc] init];
                district.district = districtArr[k];
                [city.districtArr addObject:district];
            }
            [province.cityArr addObject:city];
        }
        
        [self.placeArr addObject:province];
    }
    
    Province * province = _placeArr.firstObject;
    City * city = province.cityArr.firstObject;
    District * district = city.districtArr.firstObject;
    
    [self.view_menu configViewWithProvince:province.province city:city.city district:district.district];
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self.view addSubview:self.view_place];
    [self.view addSubview:self.view_menu];
    _view_place.hidden = YES;
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    
    [_view_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(@64);
    }];
    
    [_view_place mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(_view_menu.mas_bottom);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
    }];
}

#pragma mark - pickView delegate

- (void)menuView:(PickPlaceMenu *)menuView didSelectAtIndex:(NSInteger)index isShow:(BOOL)isShow {
    
    if (index == 0) {
        
        if (isShow) {
            
            _view_place.hidden = NO;
            
            NSMutableArray * provinceArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.placeArr.count; i++) {
                
                Province * province = _placeArr[i];
                [provinceArr addObject:province.province];
            }
            [_view_place reloadViewWithData:provinceArr component:0];
        } else {
            
            [_view_place hide];
        }
    } else if (index == 1) {
        
        if (isShow) {
            
            _view_place.hidden = NO;
            Province * province = _placeArr[_provinceIndex];
            NSMutableArray * cityArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < province.cityArr.count; i++) {
                
                City * city = province.cityArr[i];
                [cityArr addObject:city.city];
            }
            [_view_place reloadViewWithData:cityArr component:1];
        } else {
            
            [_view_place hide];
        }
    } else {
        
        if (isShow) {
            
            _view_place.hidden = NO;
            Province * province = _placeArr[_provinceIndex];
            City * city = province.cityArr[_cityIndex];
            NSMutableArray * districtArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < city.districtArr.count; i++) {
                
                District * district = city.districtArr[i];
                [districtArr addObject:district.district];
            }
            [_view_place reloadViewWithData:districtArr component:2];
        } else {
            
            [_view_place hide];
        }
    }
}

#pragma mark - placeView delegate

- (void)placeView:(PickPlaceView *)placeView didSelectPlace:(NSString *)place atComponent:(NSInteger)component atRow:(NSInteger)row {
    
    if (component == 0) {
        
        if (_provinceIndex != row) {
            
            _provinceIndex = row;
            _cityIndex = 0;
            _districtIndex = 0;
            Province * province = _placeArr[row];
            City * city = province.cityArr.firstObject;
            District * district = city.districtArr.firstObject;
            [_view_menu configViewWithProvince:place city:city.city district:district.district];
        }
    } else if (component == 1) {
        
        if (_cityIndex != row) {
            
            _cityIndex = row;
            _districtIndex = 0;
            Province * province = _placeArr[_provinceIndex];
            City * city = province.cityArr[row];
            District * district = city.districtArr.firstObject;
            [_view_menu configViewWithProvince:nil city:place district:district.district];
        }
    } else {
        
        if (_districtIndex != row) {
            
            _districtIndex = row;
            [_view_menu configViewWithProvince:nil city:nil district:place];
        }
    }
    
    [_view_menu reset];
}

- (void)placeViewDidHide {
    
    [_view_menu reset];
}

#pragma mark - setter and getter

- (PickPlaceMenu *)view_menu {
    
    if (!_view_menu) {
        
        _view_menu = [[PickPlaceMenu alloc] init];
        _view_menu.delegate = self;
    }
    return _view_menu;
}

- (PickPlaceView *)view_place {
    
    if (!_view_place) {
        
        _view_place = [[PickPlaceView alloc] init];
        _view_place.delegate = self;
    }
    return _view_place;
}

- (NSMutableArray *)placeArr {
    
    if (!_placeArr) {
        
        _placeArr = [[NSMutableArray alloc] init];
    }
    return _placeArr;
}



@end
