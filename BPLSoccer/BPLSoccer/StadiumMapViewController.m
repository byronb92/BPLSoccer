//
//  StadiumViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "StadiumMapViewController.h"
#import "AppDelegate.h"

@interface StadiumMapViewController ()
@end

@implementation StadiumMapViewController

BOOL mapPointOnlyCheck;
BOOL directionsCheck;

// If the user justs wants to see the stadium on the map without directions, set mapPointOnlyCheck to true.
-(void)setMapOnly
{
    mapPointOnlyCheck = YES;
    directionsCheck = NO;
}
// If the user wants directions to the stadium, set directionsCheck to true.
-(void)setDirectionsCheck
{
    directionsCheck = YES;
    mapPointOnlyCheck = NO;
}
- (void)viewDidLoad
{
    
    if (mapPointOnlyCheck)
    {
        self.title = self.stadiumName;
        
    }
    else
    {
        self.title = [NSString stringWithFormat:@"%@ Directions", self.directionsType];
        
    }
    [self.stadiumWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.googleMapQuery]]];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UIWebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if([error code] == NSURLErrorCancelled) return;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *errorString = [NSString stringWithFormat:
                             @"<html><font size=+2 color='red'><p>An error occurred: %@<br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>",
                             error.localizedDescription];
    [self.stadiumWebView loadHTMLString:errorString baseURL:nil];
}

@end
