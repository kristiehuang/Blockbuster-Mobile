//
//  Movie.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 7/1/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *) movie {
    self = [super init];
    self.rating = [NSString stringWithFormat:@"%@ stars", movie[@"vote_average"]];
    self.title = movie[@"title"];
    self.synopsis = movie[@"overview"];
    NSString *fullPosterUrlString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:movie[@"poster_path"]];
    self.posterUrl = [NSURL URLWithString:fullPosterUrlString];
    
    self.language = movie[@"original_language"]; //might need to reformt
    self.releaseDate = [@"Released: " stringByAppendingString:
                                  movie[@"release_date"]]; //reformat dates
    self.movieId = movie[@"id"];
    return self;
}

@end
