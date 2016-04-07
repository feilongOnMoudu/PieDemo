//
//  ViewController.m
//  pieDemo
//
//  Created by 宋飞龙 on 16/4/7.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.vircleView itemsArr:@[@"1",@"2",@"3",@"100"] colorsArr:@[[UIColor redColor],[UIColor grayColor],[UIColor cyanColor],[UIColor greenColor]]];
    //[self.vircleView  stroke];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
