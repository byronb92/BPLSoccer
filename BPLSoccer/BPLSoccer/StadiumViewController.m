//
//  StadiumViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "StadiumViewController.h"
#import "StadiumMapViewController.h"
#import "AppDelegate.h"

@interface StadiumViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation StadiumViewController

- (void)viewDidLoad
{
    // Obtain team data from the App Delegate.
    self.title = self.stadiumName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    self.teamData = [self.teams_Dict objectForKey:self.teamName];
    
    
    // Obtain maps path from bundle to load Google Maps API.
    NSURL *mapsHtmlRelativeFilePath = [[NSBundle mainBundle] URLForResource:@"maps" withExtension:@"html"];
    self.mapsHtmlAbsoluteFilePath = [mapsHtmlRelativeFilePath absoluteString];
    
    
    // Set stadium name and stadium image from information passed in from the Specific Team View Controller.
    //self.stadiumNameLabel.text = self.stadiumName;
    self.stadiumImageView.image = [UIImage imageNamed:self.stadiumImageName];
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// When the stadium image is clicked, a road map showing the location will be displayed.
- (IBAction)stadiumImageClick:(UIButton *)sender {
    NSString *stadiumCoordinates = [self.teamData objectAtIndex:5];
    NSArray *latitudeLongitude = [stadiumCoordinates componentsSeparatedByString:@","];
    // A Google map query parameter cannot have spaces. Therefore, replace each space with +
    NSString *placeNameWithNoSpaces = [self.teamName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    self.googleMapQuery = [self.mapsHtmlAbsoluteFilePath stringByAppendingFormat:@"?n=%@&lat=%@&lng=%@&zoom=16&maptype=ROADMAP",
                           placeNameWithNoSpaces, [latitudeLongitude objectAtIndex:0], [latitudeLongitude objectAtIndex:1]];
    [self performSegueWithIdentifier:@"StadiumOnMap" sender:self];
}

- (IBAction)getDirections:(UISegmentedControl *)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager startUpdatingLocation];
    

    // Obtain current latitude and longitude.
    NSString *addressFrom= [NSString stringWithFormat:@"%f,%f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    NSString *addressTo = [[self.teamData objectAtIndex:5] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    
    switch ([sender selectedSegmentIndex]) {
            
        case 0:  // Compose the Google directions query for DRIVING
            
            self.googleMapQuery = [self.mapsHtmlAbsoluteFilePath stringByAppendingFormat:@"?start=%@&end=%@&traveltype=DRIVING", addressFrom, addressTo];
            self.directionsType = @"Driving";
            break;
            
        case 1:  // Compose the Google directions query for WALKING
            
            self.googleMapQuery = [self.mapsHtmlAbsoluteFilePath stringByAppendingFormat:@"?start=%@&end=%@&traveltype=WALKING", addressFrom, addressTo];
            self.directionsType = @"Walking";
            break;
            
        case 2:  // Compose the Google directions query for BICYCLING
            
            self.googleMapQuery = [self.mapsHtmlAbsoluteFilePath stringByAppendingFormat:@"?start=%@&end=%@&traveltype=BICYCLING", addressFrom, addressTo];
            self.directionsType = @"Bicycling";
            break;
            
        case 3:  // Compose the Google directions query for TRANSIT
            
            self.googleMapQuery = [self.mapsHtmlAbsoluteFilePath stringByAppendingFormat:@"?start=%@&end=%@&traveltype=TRANSIT", addressFrom, addressTo];
            self.directionsType = @"Transit";
            break;
            
        default:
            return;
    }

    [self performSegueWithIdentifier:@"StadiumDirectionsOnMap" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"StadiumOnMap"]) {
        StadiumMapViewController *stadiumMapViewController = [segue destinationViewController];
        // Lets the MapViewController know that only a map point should be shown.
        [stadiumMapViewController setMapOnly];
        stadiumMapViewController.teamName = self.teamName;
        stadiumMapViewController.stadiumName = self.stadiumName;
        stadiumMapViewController.googleMapQuery = self.googleMapQuery;
    }
    if ([[segue identifier] isEqualToString:@"StadiumDirectionsOnMap"]) {
        StadiumMapViewController *stadiumMapViewController = [segue destinationViewController];
        // lets the MapViewController know that directions will be shown.
        [stadiumMapViewController setDirectionsCheck];
        stadiumMapViewController.teamName = self.teamName;
        stadiumMapViewController.stadiumName = self.stadiumName;
        stadiumMapViewController.directionsType = self.directionsType;
        stadiumMapViewController.googleMapQuery = self.googleMapQuery;
    }
}


@end
