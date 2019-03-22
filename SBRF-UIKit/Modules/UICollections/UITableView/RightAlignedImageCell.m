//
//  RightAlignedImageCell.m
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "RightAlignedImageCell.h"

@implementation RightAlignedImageCell
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        _animalImageView = [UIImageView new];
        [self.contentView addSubview:_animalImageView];
        _titleLabel = [UILabel new];
        [self.contentView addSubview: _titleLabel];
        _descriptionLabel = [UILabel new];
        [self.contentView addSubview:_descriptionLabel];
        
        _descriptionLabel.numberOfLines = 0;
        _animalImageView.contentMode = UIViewContentModeScaleAspectFill;
        _animalImageView.layer.masksToBounds = YES;

        return self;
    }
    
- (void)layoutSubviews
{
    CGFloat animalImageViewEgde = 40;
    self.titleLabel.frame = CGRectMake(16, 16, CGRectGetWidth(self.contentView.frame) - animalImageViewEgde - 48, 16);
    self.descriptionLabel.frame = CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame) + 8, CGRectGetWidth(self.contentView.frame) - animalImageViewEgde - 48, CGRectGetHeight(self.contentView.frame) - 40 - CGRectGetHeight(self.titleLabel.frame));
    self.animalImageView.frame = CGRectMake(CGRectGetMaxX(self.descriptionLabel.frame) + 16, 16, animalImageViewEgde, animalImageViewEgde);
        
}
    
- (void)configureWithModel:(nonnull AnimalViewModel *)model
    {
        self.titleLabel.text = model.animalName;
        self.descriptionLabel.text = model.animalDescription;
        self.animalImageView.image = model.image;
        
        [self.descriptionLabel sizeToFit];
        [self.titleLabel sizeToFit];
    }
    
    @end
