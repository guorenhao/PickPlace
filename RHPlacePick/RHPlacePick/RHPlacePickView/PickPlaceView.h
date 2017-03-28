//
//  PickPlaceView.h
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickPlaceViewDelegate;
@interface PickPlaceView : UIView

@property (nonatomic, weak) id<PickPlaceViewDelegate> delegate;

/**
 刷新展示地区的列表view

 @param dataArr   数据源：省/市/ 区、县
 @param component 菜单选中下标（这里我称之为列）
 */
- (void)reloadViewWithData:(NSArray *)dataArr component:(NSInteger)component;

/**
 收起列表
 */
- (void)hide;
@end
@protocol PickPlaceViewDelegate <NSObject>

// 代理方法
@optional

/**
 选中地区

 @param placeView 地区view
 @param place     选中的地区
 @param component 在菜单的第几个（列）
 @param row       选中的在第几行
 */
- (void)placeView:(PickPlaceView *)placeView didSelectPlace:(NSString *)place atComponent:(NSInteger)component atRow:(NSInteger)row;

/**
 展示地区view收起
 */
- (void)placeViewDidHide;

@end
