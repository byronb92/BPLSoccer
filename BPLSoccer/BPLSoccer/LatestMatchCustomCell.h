//
//  LatestMatchCustomCell.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestMatchCustomCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView  *homeImageView;
@property (nonatomic, strong) IBOutlet UILabel      *matchlabel;
@property (nonatomic, strong) IBOutlet UILabel      *scorelabel;
@property (nonatomic, strong) IBOutlet UIImageView  *awayImageView;
@end
