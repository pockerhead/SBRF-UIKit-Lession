//
//  AnimalViewModel.h
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimalViewModel : NSObject

@property (strong, nonatomic, nullable) UIImage *image;
@property (strong, nonatomic) NSString *animalName;
@property (strong, nonatomic) NSString *animalDescription;
  
- (instancetype) initWithName: (NSString *)name description:(NSString *)description andImage:(nullable UIImage *)image;
    
@end

@protocol AnimalViewModelProtocol <NSObject>
    
- (void)configureWithModel:(AnimalViewModel *)model;
    
@end

NS_ASSUME_NONNULL_END
