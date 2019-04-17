//
//  TimerFabric.m
//  SBRF-UIKit
//
//  Created by pockerhead on 13/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "TimerFabric.h"
#import <Foundation/Foundation.h>


@interface TimerFabric ()

@property (nonatomic, copy, nonnull) void(^completionBlock)(void);
@property (nonatomic, assign) NSInteger countDown;

@end

@implementation TimerFabric

- (NSTimer *)getTimerWithInterval:(NSTimeInterval)interval
                    intervalBlock:(void (^)(NSTimer *))intervalBlock
{
    return [NSTimer scheduledTimerWithTimeInterval:interval repeats:YES block:intervalBlock];
}

- (NSTimer *)getTimerWithInterval:(NSTimeInterval)interval
                        countDown:(NSInteger)countDown
                    intervalBlock:(void (^)(NSTimer *, NSInteger))intervalBlock
                  completionBlock:(void (^)(void))completionBlock
{
    self.countDown = countDown;
    return [NSTimer scheduledTimerWithTimeInterval:interval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.countDown < 1) {
            completionBlock();
            return;
        }
        intervalBlock(timer, self.countDown);
        self.countDown -= 1;
    }];
}

- (void)invocation:(NSTimer *)timer
{
    
}

@end
