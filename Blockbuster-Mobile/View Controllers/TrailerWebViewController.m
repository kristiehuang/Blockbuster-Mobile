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
@end

@implementation TrailerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.videoUrlKey);
    const NSString *baseUrl = @"https://www.youtube.com/watch?v=";
    const NSString *urlString = [baseUrl stringByAppendingString:@"key"];
    const NSURL *requestURL = [NSURL URLWithString:urlString];
    
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
