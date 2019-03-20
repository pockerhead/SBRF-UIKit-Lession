//
//  LeftAlignedImageCell.m
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "LeftAlignedImageCell.h"

@implementation LeftAlignedImageCell

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
    
    return self;
}
    
- (void)layoutSubviews
{
    self.animalImageView.frame = CGRectMake(16, 16, 40, 40);
    CGFloat labelX = CGRectGetMaxX(self.animalImageView.frame) + 16;
    self.titleLabel.frame = CGRectMake(labelX, 16, CGRectGetWidth(self.contentView.frame) - labelX - 16, 16);
    self.descriptionLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.titleLabel.frame) + 8, CGRectGetWidth(self.contentView.frame) - labelX - 16, 16);
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
