//
//  StandingsViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "StandingsViewController.h"
#import "StandingsCustomCell.h"
#import "JSONRequest.h"
#import "AppDelegate.h"

@interface StandingsViewController ()
@property (nonatomic, strong) NSMutableArray *leagueTableResults;
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@end

@implementation StandingsViewController

// Used to request match information from statsfc.com
JSONRequest *jsonRequest;


- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    
    jsonRequest = [[JSONRequest alloc] init];
    // Obtain league table array.
    self.leagueTableResults = [jsonRequest requestLeagueStandings];
    
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leagueTableResults.count;
}

// Asks the data source to return a cell to insert in a particular table view location
- (StandingsCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StandingsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamsCell"];
    NSUInteger rowNumber = [indexPath row];
    
    // Obtain the current team data from the league table array.
    NSArray *currentTeam = [self.leagueTableResults objectAtIndex:rowNumber];
    NSString *teamName = [currentTeam objectAtIndex:0];
    NSArray *teamData = [self.teams_Dict objectForKey:teamName];
    
    NSString *teamImageName = [teamData objectAtIndex:0];
    cell.teamImageView.image = [UIImage imageNamed:teamImageName];
    
    // Gather the information in the team data array and print it out.
    NSString *gamesPlayed = [currentTeam objectAtIndex:1];
    NSString *won = [currentTeam objectAtIndex:2];
    NSString *drawn = [currentTeam objectAtIndex:3];
    NSString *lost = [currentTeam objectAtIndex:4];
    NSString *goalsFor = [currentTeam objectAtIndex:5];
    NSString *goalsAgainst= [currentTeam objectAtIndex:6];
    NSString *goalDifference = [currentTeam objectAtIndex:7];
    NSString *leaguePoints = [currentTeam objectAtIndex:8];
    cell.statLabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@ - %@ - %@ - %@ - %@ - %@ - %@ - %@", gamesPlayed, won, drawn, lost, goalsFor, goalsAgainst, goalDifference, leaguePoints];
    
    // Display the team ranking. 1 is added since the rowNumber starts at 0.
    NSInteger teamRanking = rowNumber + 1;
    NSString *rankingAsString = [NSString stringWithFormat:@"%d", teamRanking];
    cell.leagueRanking.text = rankingAsString;
    
    return cell;
}

#pragma mark - Table View Delegate Methods

//       Asks the table view delegate to return the height of a given row.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewRowHeight;
}

@end
