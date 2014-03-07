//
//  AppDelegate.m
//  LoginToboggan
//
//  Created by Kelson Hootman on 11/14/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import "AppDelegate.h"
#import <MobageNDK/MobageNDK.h>
#import <FacebookSDK/FacebookSDK.h>
#include "Globals.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	// Necessary setup for Mobage SDK.  See official Mobage SDK documentation and samples for more information.
	[MBMobage initializeMobageWithServerEnvironment:SERVER_ENVIRONMENT
											  appId:APP_KEY
										 appVersion:APP_VERSION
										consumerKey:CONSUMER_KEY
									 consumerSecret:CONSUMER_SECRET];
	NSLog(@"Using Mobage NDK version %@", [[MBMobage sharedInstance] getSDKVersion]);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//Necessary for correct functioning of Facebook APIs.  See official Facebook documentation and samples for more information.
    return [FBSession.activeSession handleOpenURL:url]; 
}

@end
