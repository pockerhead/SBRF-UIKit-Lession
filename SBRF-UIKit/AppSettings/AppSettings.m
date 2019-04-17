//
//  AppSettings.m
//  SBRF-UIKit
//
//  Created by pockerhead on 17/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "AppSettings.h"


@implementation AppSettings

#pragma mark - NSUserDefaults Save - Load

+ (void)setBottomWins:(NSInteger)bottomWins
{
    [[NSUserDefaults standardUserDefaults] setInteger:bottomWins forKey:@"bottomWins"];
}

+ (NSInteger)bottomWins
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"bottomWins":@(0)}];
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"bottomWins"];
}

+ (void)setTopWins:(NSInteger)topWins
{
    [[NSUserDefaults standardUserDefaults] setInteger:topWins forKey:@"topWins"];
}

+ (NSInteger)topWins
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"topWins":@(0)}];
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"topWins"];
}

+ (void)setIsTopComputer:(BOOL)isTopComputer
{
    [[NSUserDefaults standardUserDefaults] setBool:isTopComputer forKey:kIsTopComputerKey];
}

+ (BOOL)isTopComputer
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kIsTopComputerKey:@YES}];
    return [[NSUserDefaults standardUserDefaults] integerForKey:kIsTopComputerKey];
}

+ (void)setIsBottomComputer:(BOOL)isBottomComputer
{
    [[NSUserDefaults standardUserDefaults] setBool:isBottomComputer forKey:kIsBottomComputerKey];
}

+ (BOOL)isBottomComputer
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kIsBottomComputerKey:@NO}];
    return [[NSUserDefaults standardUserDefaults] integerForKey:kIsBottomComputerKey];
}

+ (void)setSpeedSliderValue:(CGFloat)speedSliderValue
{
    [[NSUserDefaults standardUserDefaults] setFloat:speedSliderValue forKey:kSpeedSliderValue];
}

+ (CGFloat)speedSliderValue
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kSpeedSliderValue: @0.5f}];
    return [[NSUserDefaults standardUserDefaults] floatForKey:kSpeedSliderValue];
}

@end
