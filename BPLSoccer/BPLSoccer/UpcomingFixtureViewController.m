//
//  UpcomingFixtureViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "UpcomingFixtureViewController.h"
#import "UpcomingFixtureCell.h"
#import "AppDelegate.h"


@interface UpcomingFixtureViewController ()
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@end

@implementation UpcomingFixtureViewController

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamResultsData count];
}

- (UpcomingFixtureCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger rowNumber = [indexPath row];
    
    // Obtain array from the upcoming fixture to display its information.
    NSMutableArray *upcomingFixture = [self.teamResultsData objectAtIndex:rowNumber];
    NSString *homeTeam = [upcomingFixture objectAtIndex:0];
    NSString *awayTeam = [upcomingFixture objectAtIndex:1];
    NSString *dateOfMatch = [upcomingFixture objectAtIndex:2];
    
    // Obtain image of the teams involved in the match.
    NSArray *homeTeamData = [self.teams_Dict objectForKey:homeTeam];
    NSString *homeImageName = [homeTeamData objectAtIndex:0];
    NSArray *awayTeamData = [self.teams_Dict objectForKey:awayTeam];
    NSString *awayImageName = [awayTeamData objectAtIndex:0];
    
    // Create the custom cell to be instantiated at run time.
    UpcomingFixtureCell *cell = (UpcomingFixtureCell *)[tableView dequeueReusableCellWithIdentifier:@"UpcomingFixtureCell"];
    
    
    cell.matchLabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@ vs. %@", homeTeam, awayTeam];
    cell.dateLabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@", dateOfMatch];
    
    
    cell.homeImageView.image = [UIImage imageNamed:homeImageName];
    cell.awayImageView.image = [UIImage imageNamed:awayImageName];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewRowHeight;
}

@end
