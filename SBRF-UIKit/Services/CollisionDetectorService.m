//
//  CollisionDetectorService.m
//  SBRF-UIKit
//
//  Created by pockerhead on 06/04/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "CollisionDetectorService.h"


@implementation CollisionDetectorService

+ (BOOL)isRectCollide:(CGRect)rect withRect:(CGRect)secondRect
{
    return CGRectIntersectsRect(rect, secondRect);
}

+ (BOOL)isRectCollide:(CGRect)rect withSideBounds:(CGRect)bounds
{
    return CGRectGetMaxX(rect) >= CGRectGetWidth(bounds) || CGRectGetMinX(rect) <= CGRectGetMinX(bounds);
}

+ (BOOL)isRectCollide:(CGRect)rect withTopBottomBounds:(UIView *)view;
{
    return CGRectGetMaxY(rect) >= CGRectGetHeight(view.bounds) - view.safeAreaInsets.bottom || CGRectGetMinY(rect) <= view.safeAreaInsets.top;
}

@end
