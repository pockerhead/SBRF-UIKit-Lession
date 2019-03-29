//
//  SBRFMainTabBarController.m
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "SBRFMainTabBarController.h"
#import "SBRFUIKitTableViewController.h"
#import "PingPongAssembly.h"

@interface SBRFMainTabBarController ()

@end

@implementation SBRFMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureInitialViewControllers];
    self.selectedIndex = 1;
}

- (void)configureInitialViewControllers
{
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController: [PingPongAssembly createModule]];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"UIKit" image:nil tag:0];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[SBRFUIKitTableViewController new]];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"UI-Collections" image:nil tag:0];
    UINavigationController *nav3 = [UINavigationController new];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Empty" image:nil tag:0];
    self.viewControllers = @[nav1, nav2, nav3];
}
    
@end
