//
//  LeftAlignedImageCell.h
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeftAlignedImageCell : UITableViewCell <AnimalViewModelProtocol>

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* descriptionLabel;
@property (strong, nonatomic) UIImageView* animalImageView;

- (CGFloat) sizeForModel:(AnimalViewModel *)model;
    
@end

NS_ASSUME_NONNULL_END
