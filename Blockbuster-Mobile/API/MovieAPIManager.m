//
//  MovieAPIManager.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 7/1/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "MovieAPIManager.h"
#import "Movie.h"

@interface MovieAPIManager()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MovieAPIManager

- (id)init {
    self = [super init];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return self;
}

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *err) {
        if (err != nil) {
            completion(nil, err);
        } else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"results"];
            completion(dictionaries, nil);
        }
        
        
    }];
    [task resume];


}

@end
