//
//  DetailsViewController.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/24/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerWebViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *const posterView;
@property (weak, nonatomic) IBOutlet UILabel *const titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *const synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *const languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *const releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *const ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *const genreLabel;
- (IBAction)trailerButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *trailerButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fullPosterUrlString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:self.movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:fullPosterUrlString];
    [self.posterView setImageWithURL:posterURL];

    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.languageLabel.text = self.movie[@"original_language"]; //might need to reformt
    self.releaseDateLabel.text = [@"Released: " stringByAppendingString:
                                  self.movie[@"release_date"]]; //reformat dates
    self.ratingLabel.text = [@"Rating: " stringByAppendingString:
                             [NSString stringWithFormat: @"%@", self.movie[@"vote_average"]]
                             ];
    // self.genreLabel.text = genre_ids
    

        

}


- (void)fetchData {
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    //self.trailerButton = sender;
    TrailerWebViewController *webVC = [segue destinationViewController];
    webVC.videos = [self getVideos];
}

- (NSDictionary*)getVideos {
    //fetch data
    NSNumber *movie_id = self.movie[@"id"]; //wrong type
    //fetch data from video endpoint using /movie/movie_id/videos
    //videos[key[
    return self.movie[@"videos"];
}


- (IBAction)trailerButtonClicked:(id)sender {
}
@end
