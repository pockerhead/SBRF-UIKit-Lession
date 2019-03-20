//
//  AnimalViewModel.m
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "AnimalViewModel.h"

@implementation AnimalViewModel

- (instancetype) initWithName: (NSString *)name description:(NSString *)description andImage:(nullable UIImage *)image
{
    self = [super init];
    
    _animalName = name;
    _animalDescription = description;
    _image = image;
    
    return self;
}
    
@end
