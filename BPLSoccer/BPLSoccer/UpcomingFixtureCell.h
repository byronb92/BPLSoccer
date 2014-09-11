//
//  UpcomingFixtureCell.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingFixtureCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *awayImageView;
@property (strong, nonatomic) IBOutlet UILabel *matchLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@end
