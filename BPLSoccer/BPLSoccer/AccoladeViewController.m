//
//  AccoladeViewController.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "AccoladeViewController.h"
#import "AccoladeTopScorerViewController.h"
#import "AccoladeWebViewController.h"

@interface AccoladeViewController ()
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *accoladeTitle;
@end

@implementation AccoladeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSUInteger rowNumber = [indexPath row];
    
    
    if (rowNumber == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TopScorerCell"];
        cell.textLabel.text = @"Top Scorers";
    }
    else if (rowNumber == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TopAssistCell"];
        cell.textLabel.text = @"Top Assisters";
    }
    else if (rowNumber == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MostAggressiveCell"];
        cell.textLabel.text = @"Most Aggressive Players";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CleanestPlayCell"];
        cell.textLabel.text = @"Cleanest Play";
    }
    return cell;
}

// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0)
    {
        // Display the top scorers.
        [self performSegueWithIdentifier:@"ListOfTopScorers" sender:self];
    }
    else if (rowNumber == 1)
    {
        // Display the top assisters.
        self.accoladeTitle = @"Top Assisters";
        self.webURL = @"http://espnfc.com/stats/assists/_/league/eng.1/barclays-premier-league?cc=5901";
        [self performSegueWithIdentifier:@"AccoladeWebView" sender:self];
    }
    
    else if (rowNumber == 2)
    {
        // Display the top most aggressive players.
        self.accoladeTitle = @"Most Aggressive";
        self.webURL = @"http://espnfc.com/stats/discipline/_/league/eng.1/barclays-premier-league?cc=5901";
        [self performSegueWithIdentifier:@"AccoladeWebView" sender:self];
    }
    else if (rowNumber == 3)
    {
        // Display the team with the best discipline(fewest yellow/red cards)
        self.accoladeTitle = @"Cleanest Play";
        self.webURL = @"http://espnfc.com/stats/fairplay/_/league/eng.1/barclays-premier-league?cc=5901";
        [self performSegueWithIdentifier:@"AccoladeWebView" sender:self];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ListOfTopScorers"]) {
        AccoladeTopScorerViewController *accoladeController = [segue destinationViewController];
    }
    if ([[segue identifier] isEqualToString:@"AccoladeWebView"]) {
        AccoladeWebViewController *accoladeWebController = [segue destinationViewController];
        accoladeWebController.webURL = self.webURL;
        accoladeWebController.accoladeTitle = self.accoladeTitle;
    }
}


@end
