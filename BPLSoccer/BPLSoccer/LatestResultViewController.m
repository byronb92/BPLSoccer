//
//  LatestResultViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "AppDelegate.h"
#import "LatestResultViewController.h"
#import "LatestMatchCustomCell.h"

@interface LatestResultViewController ()
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;

@end

@implementation LatestResultViewController

- (void)viewDidLoad
{
    // Acquire the dictionary of BPL teams from the app delegate.
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

- (LatestMatchCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger rowNumber = [indexPath row];
    
    // Obtains the array of data requested with JSON from the SpecificTeamViewController.
    NSMutableArray *currentMatchResult = [self.teamResultsData objectAtIndex:rowNumber];
    
    NSString *homeTeam = [currentMatchResult objectAtIndex:0];
    NSString *awayTeam = [currentMatchResult objectAtIndex:1];
    NSString *homeScore = [currentMatchResult objectAtIndex:2];
    NSString *awayScore = [currentMatchResult objectAtIndex:3];
    
    // Obtain images for the corresponding hoem and away team.
    NSArray *homeTeamData = [self.teams_Dict objectForKey:homeTeam];
    NSString *homeImageName = [homeTeamData objectAtIndex:0];
    NSArray *awayTeamData = [self.teams_Dict objectForKey:awayTeam];
    NSString *awayImageName = [awayTeamData objectAtIndex:0];
    
    // Creates custom cell to be instantiated during runtime.
    LatestMatchCustomCell *cell = (LatestMatchCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"MatchResultCell"];
    
    
    cell.matchlabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@ vs. %@", homeTeam, awayTeam];
    cell.scorelabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@ - %@", homeScore, awayScore];
    
    

    cell.homeImageView.image = [UIImage imageNamed:homeImageName];
    cell.awayImageView.image = [UIImage imageNamed:awayImageName];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

// Asks the table view delegate to return the height of a given row.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewRowHeight;
}

@end
