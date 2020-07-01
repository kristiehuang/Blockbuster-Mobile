//
//  MoviesViewController.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/24/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "MovieAPIManager.h"

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray<Movie*> *movies;
@property (nonatomic, strong) NSMutableArray<Movie*> *filteredMovies;
@property (weak, nonatomic) IBOutlet UITableView *const tableView;
@property (nonatomic, strong) UIRefreshControl *const refreshControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.movies = [[NSMutableArray alloc] init];
    self.filteredMovies = [[NSMutableArray alloc] init];
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0]; //programatically lay their view
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.filteredMovies[indexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.movie = movie;
}


- (void)fetchMovies {
    MovieAPIManager *manager = [MovieAPIManager new];
    [manager fetchNowPlaying:^(NSArray * _Nonnull movies, NSError * _Nonnull error) {
        
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
               self.movies = [[NSMutableArray alloc] init];

               for (NSDictionary *dict in movies) {
                   Movie *m = [[Movie alloc] initWithDictionary:dict];
                   [self.movies addObject:m];
               }
               self.filteredMovies = self.movies;

               [self.tableView performSelectorOnMainThread:NSSelectorFromString(@"reloadData") withObject:nil waitUntilDone:YES];
//               [self.tableView reloadData];

           }

    }];
    [self.refreshControl endRefreshing];
 
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    [cell setMovie:self.filteredMovies[indexPath.row]];
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Movie* evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString *searched = [[evaluatedObject.title stringByAppendingString:
                                   [NSString stringWithFormat:@" %@", evaluatedObject.synopsis]] lowercaseString];
            return [searched containsString:[searchText lowercaseString]];
        }];
        self.filteredMovies = [NSMutableArray arrayWithArray:[self.movies filteredArrayUsingPredicate:predicate]];
        
    } else {
        self.filteredMovies = self.movies;
    }
    [self.tableView reloadData];

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    [self searchBar:self.searchBar textDidChange:@""];
    [self.tableView reloadData];

}

@end
