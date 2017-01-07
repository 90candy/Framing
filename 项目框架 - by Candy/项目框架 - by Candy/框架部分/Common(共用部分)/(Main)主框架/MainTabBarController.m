//
//  MainTabBarController.m
//  项目框架 - by Candy
//
//  Created by Candy on 17/1/5.
//  Copyright © 2017年 Candy. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "SchoolViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *viewControllers = @[[[HomeViewController alloc]init],[[SchoolViewController alloc]init],[[MessageViewController alloc]init],[[MineViewController alloc]init]];
    //标签控制器 - 标题
    NSArray *tabBarItemTitle = @[@"首 页",@"学 校",@"消 息",@"我 的"];
    //标签控制器 - 正常图片
    NSArray *tabBarItemImageName = @[@"menu_home_normal", @"menu_school_normal", @"menu_interactive_normal", @"menu_mine_normal"];
    //标签控制器 - 选中图片
    NSArray *tabBarItemSelectedImageName = @[@"menu_home_selected", @"menu_school_selected", @"menu_interactive_selected", @"menu_mine_selected"];
    _VCArray = [NSMutableArray array];
    
    for (int i = 0; i<viewControllers.count; i++) {
        UIViewController * vc = viewControllers[i];
        //方法一：直接初始化
        //UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:tabBarItemTitle[i] image:[UIImage imageNamed:tabBarItemImageName[i]] selectedImage:[UIImage imageNamed:tabBarItemSelectedImageName[i]]];
        //方法二：设置图片渲染
        UITabBarItem * item = [[UITabBarItem alloc] init];
        [item setTitle:tabBarItemTitle[i]];
        item.image = [[UIImage imageNamed:tabBarItemImageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:tabBarItemSelectedImageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = item;
        vc.title = tabBarItemTitle[i];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.barTintColor = COLOR_RGB(235, 235, 235, 0.2);
        nav.view.backgroundColor = COLOR_RGB(235, 235, 235, 0.9);
        [_VCArray addObject:nav];
    }
    
    //设置标签栏风格(默认高度49)
    self.tabBar.barStyle = UIBarStyleBlack;
    //设置初始状态选中的下标
    self.selectedIndex = 3;
    //设置标签栏文字和图片的颜色
    self.tabBar.tintColor = [UIColor whiteColor];
    //设置标签栏的颜色
    self.tabBar.barTintColor = [UIColor lightGrayColor];
    self.delegate = self;
    self.viewControllers = _VCArray;
}

@end
