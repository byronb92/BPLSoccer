//
//  RosterWebViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/14/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterWebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *rosterWebView;
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *rosterURL;

@end
