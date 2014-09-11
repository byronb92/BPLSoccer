//
//  StadiumMapViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StadiumMapViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *teamName;

@property (strong, nonatomic) NSString *stadiumName;
@property (strong, nonatomic) IBOutlet UIWebView *stadiumWebView;

@property (strong, nonatomic) NSString *googleMapQuery;
@property (strong, nonatomic) NSString *directionsType;


-(void)setMapOnly;
-(void)setDirectionsCheck;
@end
