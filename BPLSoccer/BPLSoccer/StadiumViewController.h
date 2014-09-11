//
//  StadiumViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface StadiumViewController : UIViewController

@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@property (strong, nonatomic) NSString *teamName;
@property (nonatomic, strong) NSMutableArray *teamData;

// Stadium name passed in from SpecificTeamViewController
@property (strong, nonatomic) NSString *stadiumName;
@property (strong, nonatomic) NSString *stadiumImageName;
@property (strong, nonatomic) IBOutlet UIImageView *stadiumImageView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *directionsSegmentedControl;
@property (strong, nonatomic) NSString *mapsHtmlAbsoluteFilePath;
@property (strong, nonatomic) NSString *googleMapQuery;
@property (strong, nonatomic) NSString *directionsType;

- (IBAction)stadiumImageClick:(UIButton *)sender;
- (IBAction)getDirections:(UISegmentedControl *)sender;


@end
