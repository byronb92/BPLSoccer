//
//  AccoladeWebViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "AccoladeWebViewController.h"

@interface AccoladeWebViewController ()

@end

@implementation AccoladeWebViewController

- (void)viewDidLoad
{
    self.title = self.accoladeTitle;
    [self.accoladeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    [super viewDidLoad];
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
    [self.accoladeWebView loadHTMLString:errorString baseURL:nil];
}

@end
