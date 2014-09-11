//
//  UpcomingFixtureViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#define       kTableViewRowHeight  60;

@interface UpcomingFixtureViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *upcomingFixtureTableView;

@property (nonatomic, strong) NSMutableArray *teamResultsData;


@end
