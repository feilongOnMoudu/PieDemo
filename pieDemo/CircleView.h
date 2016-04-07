//
//  CircleView.h
//  pieDemo
//
//  Created by 宋飞龙 on 16/4/7.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

- (void)itemsArr:(NSArray *)itemsArr
               colorsArr:(NSArray *)colorsArr;
- (void)stroke;
@end
