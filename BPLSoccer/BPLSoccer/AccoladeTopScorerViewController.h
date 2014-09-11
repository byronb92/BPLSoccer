//
//  AccoladeTopScorerViewController.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccoladeTopScorerViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *topScorerData;
@property (strong, nonatomic) IBOutlet UITableView *topScorerTableview;

@end
