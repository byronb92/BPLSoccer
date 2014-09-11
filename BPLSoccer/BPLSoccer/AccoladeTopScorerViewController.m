//
//  AccoladeTopScorerViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "AccoladeTopScorerViewController.h"
#import "JSONRequest.h"
#import "AppDelegate.h"

@interface AccoladeTopScorerViewController ()
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@end

@implementation AccoladeTopScorerViewController
JSONRequest *jsonRequest;

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    
    jsonRequest = [[JSONRequest alloc] init];
    self.topScorerData = [jsonRequest requestTopScorers];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topScorerData.count;
}

// Asks the data source to return a cell to insert in a particular table view location
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopScorerGoalsCell"];
    NSUInteger rowNumber = [indexPath row];
    
    NSArray *currentPlayerData = [self.topScorerData objectAtIndex:rowNumber];
    NSString *teamName = [currentPlayerData objectAtIndex:2];
    NSArray *teamData = [self.teams_Dict objectForKey:teamName];
    
    NSString *teamImageName = [teamData objectAtIndex:0];
    cell.imageView.image = [UIImage imageNamed:teamImageName];
    
    NSString *currentPlayerName = [currentPlayerData objectAtIndex:0];
    NSString *currentPlayerGoals = [currentPlayerData objectAtIndex:1];
    cell.textLabel.text = currentPlayerName;
    cell.detailTextLabel.text = [[[NSString alloc] init] stringByAppendingFormat:@"%@ Goals Scored", currentPlayerGoals];
    
    return cell;
}

@end
