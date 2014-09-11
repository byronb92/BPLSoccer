//
//  AppDelegate.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/3/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Obtain file path of the teams plist.
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"Teams" ofType:@"plist"];
    
    self.teams_Dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.teamNames = [[self.teams_Dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return YES;
}
							

@end
