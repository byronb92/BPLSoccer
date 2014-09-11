//
//  JSONRequests.m
//  BPLSoccer
//
//  Created by Byron Becker on 12/15/13.
//  Copyright (c) 2013 Byron Becker. All rights reserved.
//
//  All data obtained from requests has been obtained from https://statsfc.com/

#import "JSONRequest.h"

@implementation JSONRequest

// API Key achieved by registering for stats.fc. If this is invalid, request another API key and replace the key here.
NSString *apiKey = @"A3m_8WlD7hvFJFpitA_TYPV5xG1GNc2mPq8XtV5w";


// Requests latest results for the specified team.
-(NSMutableArray*)requestLatestResults:(NSString *)team
{
    // Some team names contain spaces. We must delete these in order to get the correct data.
    NSString *teamNameWithNoSpaces = [team stringByReplacingOccurrencesOfString:@" " withString:@"-"];

    // Get Fixtures URL.
    NSString *latestResults = [[NSString alloc] init];
    latestResults = [latestResults stringByAppendingFormat:@"http://api.statsfc.com/results.json?key=%@&competition=premier-league&team=%@", apiKey, teamNameWithNoSpaces];
    
    // Perform JSON request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:latestResults]];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
    
    // Returns Array of Dictionary.
    // key: "home" - home team.
    //      "away" - away team.
    //      "fulltime" - contains MutableArray with score values.
    //          index 0 = home score
    //          index 1 = away score
    // If there is an error, return null and print to the console.
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", err);
        return NULL;
    }
    
    // Set up the array that will contain the relevant result information.
    NSMutableArray *matchResults = [[NSMutableArray alloc] init];
    
    // Set up placeholder variables that will temporarily hold the data for match.
    NSMutableDictionary *currentGame;
    NSString *homeTeam;
    NSString *awayTeam;
    NSMutableArray *matchResult;
    NSString *homeScore;
    NSString *awayScore;
    
    // The information contained in this array will be as follows.
    // Index 1 - home team.
    // Index 2 - away team.
    // Index 3 - home score.
    // Index 4 - away score.

    
    // Iterate through each dictionary and only acquire the relevant information.
    for (int i = 0; i < jsonArray.count; i++)
    {
        currentGame = [jsonArray objectAtIndex:i];
        homeTeam = [currentGame objectForKey:@"home"];
        awayTeam = [currentGame objectForKey:@"away"];
        
        // Key "fulltime" will return an array of two numbers.
        // The first index holds the home score, and the second index holds the away score.
        matchResult = [currentGame objectForKey:@"fulltime"];
        homeScore = [[matchResult objectAtIndex:0] stringValue];
        awayScore = [[matchResult objectAtIndex:1] stringValue];
        
        // Add all of the information into one temporary array symbolizing 1 game.
        NSMutableArray *tempGameResults = [[NSMutableArray alloc] init];
        [tempGameResults addObject:homeTeam];
        [tempGameResults addObject:awayTeam];
        [tempGameResults addObject:homeScore];
        [tempGameResults addObject:awayScore];
        
        // Add current game array to the total game array.
        [matchResults addObject:tempGameResults];
    }
    return matchResults;
}


// Requests upcoming matches for the specified team.
-(NSMutableArray*)requestTeamFixtures:(NSString *)team
{
    // Some team names contain spaces. We must delete these in order to get the correct data.
    NSString *teamNameWithNoSpaces = [team stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    // Get Fixtures URL.
    NSString *teamFixtures = [[NSString alloc] init];
    teamFixtures = [teamFixtures stringByAppendingFormat:@"http://api.statsfc.com/fixtures.json?key=%@&competition=premier-league&team=%@", apiKey, teamNameWithNoSpaces];
    
    // Perform JSON request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:teamFixtures]];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
    
    // If there is an error, catch and perform an alert.
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", err);
        return NULL;
    }
    // Request will return a Mutable Dictionary.
    // We only want these three keys:
    // home - Home team string
    // away - Away team string
    // date - Date time string
    NSMutableArray *upcomingFixtures = [[NSMutableArray alloc] init];
    
    // Set up placeholder variables that will temporarily hold the data for match.
    NSMutableDictionary *currentUpcomingGame;
    NSString *homeTeam;
    NSString *awayTeam;
    NSString *dateOfGame;
    
    
    // Iterate through each dictionary and only acquire the relevant information.
    for (int i = 0; i < jsonArray.count; i++)
    {
        currentUpcomingGame = [jsonArray objectAtIndex:i];
        homeTeam = [currentUpcomingGame objectForKey:@"home"];
        awayTeam = [currentUpcomingGame objectForKey:@"away"];
        dateOfGame = [currentUpcomingGame objectForKey:@"date"];
        
        // Add all of the information into one temporary array symbolizing 1 game.
        NSMutableArray *tempGameResults = [[NSMutableArray alloc] init];
        [tempGameResults addObject:homeTeam];
        [tempGameResults addObject:awayTeam];
        [tempGameResults addObject:dateOfGame];
        
        // Add current game array to the total game array.
        [upcomingFixtures addObject:tempGameResults];
    }
    return upcomingFixtures;
}


// Obtains the most recent league table.
-(NSMutableArray*)requestLeagueStandings
{
    // Get league standings URL
    NSString *leagueStandingURL = [[NSString alloc] init];
    leagueStandingURL = [leagueStandingURL stringByAppendingFormat:@"http://api.statsfc.com/table.json?key=%@&competition=premier-league", apiKey];

    
    // Perform JSON request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:leagueStandingURL]];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
    
    // If there is an error, catch and perform an alert.
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", err);
        return NULL;
    }
    
    NSMutableArray *leagueTable = [[NSMutableArray alloc] init];
    
    // We want to obtain the following keys:
    // team - teamName
    // played - games played (long)
    // won - games won (int)
    // drawn - games drawn (int)
    // lost - games lost (int)
    // for - goals for (long)
    // against - goals against (long)
    // difference - goal difference (long)
    // points - league points (long)
    

    for (int i = 0; i < jsonArray.count; i++)
    {
        NSMutableDictionary *currentTeam = [jsonArray objectAtIndex:i];
        NSString *currentTeamName = [currentTeam objectForKey:@"team"];
        NSString *gamesPlayed = [[currentTeam objectForKey:@"played"] stringValue];
        NSString *gamesWon = [[currentTeam objectForKey:@"won"] stringValue];
        NSString *gamesDrawn = [[currentTeam objectForKey:@"drawn"] stringValue];
        NSString *gamesLost = [[currentTeam objectForKey:@"lost"] stringValue];
        NSString *goalsFor = [[currentTeam objectForKey:@"for"] stringValue];
        NSString *goalsAgainst = [[currentTeam objectForKey:@"against"] stringValue];
        NSString *goalDifference = [[currentTeam objectForKey:@"difference"] stringValue];
        NSString *leaguePoints = [[currentTeam objectForKey:@"points"] stringValue];
        
        
        // Add all of the information into one temporary array symbolizing 1 team.
        NSMutableArray *tempTeamStats = [[NSMutableArray alloc] init];
        [tempTeamStats addObject:currentTeamName];
        [tempTeamStats addObject:gamesPlayed];
        [tempTeamStats addObject:gamesWon];
        [tempTeamStats addObject:gamesDrawn];
        [tempTeamStats addObject:gamesLost];
        [tempTeamStats addObject:goalsFor];
        [tempTeamStats addObject:goalsAgainst];
        [tempTeamStats addObject:goalDifference];
        [tempTeamStats addObject:leaguePoints];
        
        // Add current team array to the leagueTable array.
        [leagueTable addObject:tempTeamStats];
    }
    return leagueTable;
}

// Obtain the top scorers currently in the BPL.
-(NSMutableArray*)requestTopScorers
{
        // Get top scorers URL.
        NSString *leagueStandingURL = [[NSString alloc] init];
        leagueStandingURL = [leagueStandingURL stringByAppendingFormat:@"http://api.statsfc.com/top-scorers.json?key=%@&competition=premier-league", apiKey];
        
        
        // Perform JSON request.
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:leagueStandingURL]];
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
        
        NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        
        // If there is an error, catch and perform an alert.
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", err);
            return NULL;
        }
    // We only care about 3 keys:
    //      player - player name
    //      goals - number of goals
    //      team - team they play for.

    NSMutableArray *topScorers = [[NSMutableArray alloc]init];
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSMutableDictionary *currentPlayer = [jsonArray objectAtIndex:i];
        NSString *playerName = [currentPlayer objectForKey:@"player"];
        NSString *goalsScored = [[currentPlayer objectForKey:@"goals"] stringValue];
        NSString *teamOfPlayer = [currentPlayer objectForKey:@"team"];
        
        
        // Add all of the information into one temporary array symbolizing 1 player.
        NSMutableArray *tempPlayerStats = [[NSMutableArray alloc] init];
        [tempPlayerStats addObject:playerName];
        [tempPlayerStats addObject:goalsScored];
        [tempPlayerStats addObject:teamOfPlayer];
        // Add current player array to the complete list of top scorers.
        [topScorers addObject:tempPlayerStats];
    }

    return topScorers;
}

@end
