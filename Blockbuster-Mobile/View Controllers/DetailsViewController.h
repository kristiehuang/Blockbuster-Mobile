//
//  DetailsViewController.h
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/24/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Movie *movie;
@end

NS_ASSUME_NONNULL_END
