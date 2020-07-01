//
//  MovieAPIManager.h
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 7/1/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieAPIManager : NSObject

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
