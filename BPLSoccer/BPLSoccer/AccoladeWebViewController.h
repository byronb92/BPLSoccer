//
//  AccoladeWebViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccoladeWebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *accoladeWebView;
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *accoladeTitle;
@end
