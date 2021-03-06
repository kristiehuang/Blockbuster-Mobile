//
//  MoviesGridViewController.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/25/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "Movie.h"

@interface MoviesGridViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray<Movie*> *movies;
@property (nonatomic, strong) NSMutableArray<Movie*> *filteredMovies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.movies = [[NSMutableArray alloc] init];
    self.filteredMovies = [[NSMutableArray alloc] init];

    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    CGFloat postersPerLine = 2;
    CGFloat viewWidth = self.collectionView.frame.size.width - (postersPerLine - 1)*layout.minimumInteritemSpacing;
    layout.itemSize = CGSizeMake(viewWidth / postersPerLine, viewWidth / postersPerLine * 1.5);
    
    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Movie *movie = self.filteredMovies[indexPath.item];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.movie = movie;
}

#pragma mark - Table View

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:[error localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self fetchMovies];
                }];
                [alert addAction:cancelAction];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:^{
                }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.movies = [[NSMutableArray alloc] init];

               for (NSDictionary *dict in dataDictionary[@"results"]) {
                   Movie *m = [[Movie alloc] initWithDictionary:dict];
                   [self.movies addObject:m];
               }
               self.filteredMovies = self.movies;

               [self.collectionView reloadData];
           }
       }];
    [task resume];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    
    Movie *movie = self.filteredMovies[indexPath.item];
    cell.posterImage.image = nil;
    if (movie.posterUrl != nil) {
        [cell.posterImage setImageWithURL:movie.posterUrl];

    }
    
    cell.contentView.layer.cornerRadius = 10.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;

    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.3f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Movie *evaluatedObject, NSDictionary *bindings) {
            NSString *searched = [[evaluatedObject.title stringByAppendingString:
                                   [NSString stringWithFormat:@" %@", evaluatedObject.synopsis]] lowercaseString];
            return [searched containsString:[searchText lowercaseString]];
        }];
        self.filteredMovies = [NSMutableArray arrayWithArray:[self.movies filteredArrayUsingPredicate:predicate]];
    }
    else {
        self.filteredMovies = self.movies;
    }
    [self.collectionView reloadData];
}

/** Hide the keyboard . */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    [self searchBar:self.searchBar textDidChange:@""];
    [self.collectionView reloadData];
}

@end
