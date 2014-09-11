//
//  NewsViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsWebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *newsWebView;

@end
