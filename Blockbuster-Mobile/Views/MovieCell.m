//
//  MovieCell.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/24/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMovie:(Movie *)movie {
    self.ratingLabel.text = movie.rating;
    self.titleLabel.text = movie.title;
    self.synopsisLabel.text = movie.synopsis;
    self.posterImage.image = nil;
    if (movie.posterUrl != nil) {
        [self.posterImage setImageWithURL:movie.posterUrl];
    }
}

@end
