//
//  StandingsCustomCell.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/16/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *teamImageView;
@property (strong, nonatomic) IBOutlet UILabel *statLabel;

@property (strong, nonatomic) IBOutlet UILabel *leagueRanking;
@end
