//
//  SpecificTeamViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/14/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "SpecificTeamViewController.h"
#import "RosterWebViewController.h"
#import "StadiumViewController.h"
#import "LatestResultViewController.h"
#import "UpcomingFixtureViewController.h"

#import "AppDelegate.h"
#import "JSONRequest.h"

@interface SpecificTeamViewController ()
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@property (nonatomic, strong) NSArray *teamNames;
// Array of recent team results that will be passed ot the LatestResultViewController
@property (nonatomic, strong) NSMutableArray *teamResultsData;
@end

@implementation SpecificTeamViewController

// Used to request match information from statsfc.com
JSONRequest *jsonRequest;

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    self.teamNames = appDelegate.teamNames;

    
    // Team Information is stored in the array "teamData" which was passed in from the "TeamsViewController"
    self.title = [self.teamData objectAtIndex:0];
    
    jsonRequest = [[JSONRequest alloc] init];
    
    [super viewDidLoad];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Asks the data source to return the number of rows in a given section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

// Set the table view section header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"General Information";
    }
    return @"Match Information";
}
// Asks the data source to return a cell to insert in a particular table view location
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSUInteger sectionNumber = [indexPath section];
    NSUInteger rowNumber = [indexPath row];
    

    if (sectionNumber == 0 && rowNumber == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RosterCell"];
    }
    else if (sectionNumber == 0 && rowNumber == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StadiumCell"];
        cell.textLabel.text = @"Stadium Location";
    }
    else if (sectionNumber == 1 && rowNumber == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
        cell.textLabel.text = @"Latest Results";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FixtureCell"];
        cell.textLabel.text = @"Upcoming Fixtures";
    }
    return cell;
}



// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Row 0 = Roster
    NSUInteger sectionNumber = [indexPath section];
    NSUInteger rowNumber = [indexPath row];
    
    if (sectionNumber == 0)
    {
        if (rowNumber == 0)
        {
            // Display roster web controller.
            [self performSegueWithIdentifier:@"RosterOfTeam" sender:self];
        }
        else if (rowNumber == 1)
        {
            // Display stadium location/directions.
            [self performSegueWithIdentifier:@"StadiumOfTeam" sender:self];
        }
    }
    else if ( sectionNumber == 1)
    {
        if (rowNumber == 0)
        {
            // Display league results.
            NSString *selectedTeamName = [self.teamData objectAtIndex:0];
            self.teamResultsData = [jsonRequest requestLatestResults:selectedTeamName];
            [self performSegueWithIdentifier:@"LatestResultOfTeam" sender:self];
        }
        else if (rowNumber ==1)
        {

            // Obtain team fixtures.
            NSString *selectedTeamName = [self.teamData objectAtIndex:0];
            self.teamResultsData = [jsonRequest requestTeamFixtures:selectedTeamName];
            [self performSegueWithIdentifier:@"UpcomingFixturesOfTeam" sender:self];
            
        }
    }
    // Perform the segue.
    //[self performSegueWithIdentifier:@"SpecificTeam" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RosterOfTeam"]) {
        RosterWebViewController *rosterWebViewController = [segue destinationViewController];
        NSString *teamName = [self.teamData objectAtIndex:0];
        NSString *teamNameWithRoster = [teamName stringByAppendingString:@" Roster"];
        rosterWebViewController.teamName = teamNameWithRoster;
        rosterWebViewController.rosterURL = [self.teamData objectAtIndex:2];
    }
    if ([[segue identifier] isEqualToString:@"StadiumOfTeam"]) {
        StadiumViewController *stadiumViewController = [segue destinationViewController];
        
        NSString *teamName = [self.teamData objectAtIndex:0];
        NSString *stadiumName = [self.teamData objectAtIndex:3];
        NSString *stadiumImageName = [self.teamData objectAtIndex:4];
        
        stadiumViewController.teamName = teamName;
        stadiumViewController.stadiumName = stadiumName;
        stadiumViewController.stadiumImageName = stadiumImageName;
    }
    if ([[segue identifier] isEqualToString:@"LatestResultOfTeam"]) {
        LatestResultViewController *latestResultController = [segue destinationViewController];
        latestResultController.teamResultsData = self.teamResultsData;
    }
    
    if ([[segue identifier] isEqualToString:@"UpcomingFixturesOfTeam"]) {
        UpcomingFixtureViewController *upcomingFixtureController = [segue destinationViewController];
        upcomingFixtureController.teamResultsData = self.teamResultsData;
    }
    
}
@end
