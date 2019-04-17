//
//  AppSettings.h
//  SBRF-UIKit
//
//  Created by pockerhead on 17/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


NS_ASSUME_NONNULL_BEGIN

@interface AppSettings : NSObject

+ (void)setBottomWins:(NSInteger)bottomWins;
+ (NSInteger)bottomWins;

+ (void)setTopWins:(NSInteger)topWins;
+ (NSInteger)topWins;

+ (void)setIsTopComputer:(BOOL)isTopComputer;
+ (BOOL)isTopComputer;

+ (void)setIsBottomComputer:(BOOL)isBottomComputer;
+ (BOOL)isBottomComputer;

+ (void)setSpeedSliderValue:(CGFloat)speedSliderValue;
+ (CGFloat)speedSliderValue;

@end

NS_ASSUME_NONNULL_END
