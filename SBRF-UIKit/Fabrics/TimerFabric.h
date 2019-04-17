//
//  TimerFabric.h
//  SBRF-UIKit
//
//  Created by pockerhead on 13/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TimerFabric : NSObject

- (NSTimer *)getTimerWithInterval:(NSTimeInterval)interval
                    intervalBlock:(void (^)(NSTimer *))intervalBlock;

- (NSTimer *)getTimerWithInterval:(NSTimeInterval)interval
                        countDown:(NSInteger)countDown
                    intervalBlock:(void (^)(NSTimer *, NSInteger))intervalBlock
                  completionBlock:(void (^)(void))completionBlock;


@end

NS_ASSUME_NONNULL_END
