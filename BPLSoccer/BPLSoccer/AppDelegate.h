//
//  AppDelegate.h
//  BPLSoccer
//
//  Created by Byron Becker on 12/3/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) NSMutableDictionary *teams_Dict;
@property (nonatomic, strong) NSArray *teamNames;
// Team Data will be passed to a different View Controller to show information specifically related
// to the selected team.
@property (nonatomic, strong) NSMutableArray *teamData;
@property (strong, nonatomic) UIWindow *window;

@end
