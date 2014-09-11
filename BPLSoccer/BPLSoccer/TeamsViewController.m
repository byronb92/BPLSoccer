//
//  TeamsViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/14/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "TeamsViewController.h"
#import "AppDelegate.h"
#import "SpecificTeamViewController.h"

@interface TeamsViewController ()
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@property (nonatomic, strong) NSArray *teamNames;
// Team Data will be passed to a different View Controller to show information specifically related to the selected team.
@property (nonatomic, strong) NSMutableArray *teamData;
@property (nonatomic, strong) NSMutableArray *teamTableViewContent;
@end

@implementation TeamsViewController


- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.teams_Dict = appDelegate.teams_Dict;
    self.teamNames = appDelegate.teamNames;
    
    self.teamTableViewContent = [[NSMutableArray alloc] init];
    [self.teamTableViewContent addObjectsFromArray:self.teamNames];
    
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamTableViewContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamsCell"];
    NSUInteger rowNumber = [indexPath row];
    NSString *teamName = [self.teamNames objectAtIndex:rowNumber];
    NSArray *teamData = [self.teams_Dict objectForKey:teamName];
    
    NSString *teamImageName = [teamData objectAtIndex:0];
    cell.textLabel.text  = teamName;
    cell.imageView.image = [UIImage imageNamed:teamImageName];


    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    NSString *teamName = [self.teamNames objectAtIndex:rowNumber];
    
    NSArray *specificTeamData_Array = [self.teams_Dict objectForKey:teamName];
    NSMutableArray *specificTeamData = [[NSMutableArray alloc] initWithArray:specificTeamData_Array];
    self.teamData = specificTeamData;
    
    // Include the team name in the array to pass to the next controller.
    [self.teamData insertObject:teamName atIndex:0];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"SpecificTeam" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SpecificTeam"]) {
        SpecificTeamViewController *specificTeamViewController = [segue destinationViewController];
        specificTeamViewController.teamData = self.teamData;
    }
}


@end
