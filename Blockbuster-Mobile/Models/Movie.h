//
//  Movie.h
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 7/1/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSNumber *movieId;

@property (nonatomic, strong) NSURL *posterUrl;

- (id)initWithDictionary:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
