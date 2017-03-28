//
//  PickPlaceMenu.h
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickPlaceMenuDelegate;
@interface PickPlaceMenu : UIView

@property (nonatomic, weak) id<PickPlaceMenuDelegate> delegate;

/**
 配置菜单

 @param province 省
 @param city     市
 @param district 区/县
 */
- (void)configViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;

/**
 重置菜单
 */
- (void)reset;
@end
@protocol PickPlaceMenuDelegate <NSObject>

@optional
/**
 点击菜单

 @param menuView 菜单view
 @param index    选中菜单的下标：0代表省，1代表市，2代表区/县
 @param isShow   是否弹出显示当前的对应列表
 */
- (void)menuView:(PickPlaceMenu *)menuView didSelectAtIndex:(NSInteger)index isShow:(BOOL)isShow;
@end
