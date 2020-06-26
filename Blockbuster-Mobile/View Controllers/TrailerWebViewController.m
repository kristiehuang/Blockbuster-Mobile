//
//  TrailerWebViewController.m
//  Blockbuster-Mobile
//
//  Created by Kristie Huang on 6/26/20.
//  Copyright © 2020 Kristie Huang. All rights reserved.
//

#import "TrailerWebViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerWebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) NSArray *videos;
@end

@implementation TrailerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getVideos];

}

- (void)getVideos {
    NSNumber *movie_id = self.movie[@"id"]; //wrong type
    NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed", movie_id]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:[error localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self getVideos];
                }];
                [alert addAction:cancelAction];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:^{
                }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.videos = dataDictionary[@"results"];
               
               if (self.videos.count == 0) {
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"There were no trailers!" message:[error localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                   UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   }];
                   [alert addAction:cancelAction];
                   [self presentViewController:alert animated:YES completion:^{
                   }];
               } else {
                   const NSString *baseUrl = @"https://www.youtube.com/watch?v=";
                   const NSString *urlString = [baseUrl stringByAppendingString:
                                                 [NSString stringWithFormat:@"%@", self.videos[0][@"key"]]];
                   NSURL *requestURL = [NSURL URLWithString:urlString];
                   NSURLRequest *request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
                   [self.webView loadRequest:request];
               }
           }
       }];
    [task resume];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
