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

@property (weak, nonatomic) NSArray *const videos;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.movie.posterUrl != nil) {
        [self.posterView setImageWithURL:self.movie.posterUrl];
    }

    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.synopsis;
    self.languageLabel.text = self.movie.language;
    self.releaseDateLabel.text = self.movie.releaseDate;
    self.ratingLabel.text = self.movie.rating;

}


- (void)fetchData {
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrailerWebViewController *webVC = [segue destinationViewController];
    webVC.movie = self.movie;
}



- (IBAction)trailerButtonClicked:(id)sender {
}
@end
