//
//  CollisionDetectorService.h
//  SBRF-UIKit
//
//  Created by pockerhead on 06/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface CollisionDetectorService : NSObject

+ (BOOL)isRectCollide:(CGRect)rect withSideBounds:(CGRect)bounds;
+ (BOOL)isRectCollide:(CGRect)rect withTopBottomBounds:(UIView *)view;
+ (BOOL)isRectCollide:(CGRect)rect withRect:(CGRect)secondRect;

@end

NS_ASSUME_NONNULL_END
