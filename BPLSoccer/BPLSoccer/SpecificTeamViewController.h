//
//  SpecificTeamViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/14/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecificTeamViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *specificTeamTableView;
@property (nonatomic, strong) NSMutableArray *teamData;


@end
