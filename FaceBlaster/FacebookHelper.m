//
//  FacebookHelper.m
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/10/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import "FacebookHelper.h"
#import "UIUtil.h"

@implementation FacebookHelper

+ (void)loginWithCallback:(void (^)(NSError * error))callback
{
	[FBSession openActiveSessionWithReadPermissions:@[@"read_friendlists", @"email"]
									   allowLoginUI:YES
								  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
		if ((status & FB_SESSIONSTATEOPENBIT) || error) {
			callback(error);
		} else {
			callback(nil);
		}
	}];
}

+ (void)logOut
{
	if (FBSession.activeSession.isOpen) {
		[FBSession.activeSession close];
		[FBSession.activeSession closeAndClearTokenInformation];
		FBSession.activeSession = nil;
	}
}

+ (void)requestUserInfoWithCallback:(void (^)(NSError *error, NSString * fbID, NSString * fbToken, NSString * picture, NSString * firstName, NSString * lastName)) callback
{
	[FBRequestConnection startWithGraphPath:@"me" parameters:[NSDictionary dictionaryWithObject:@"picture,id,first_name,last_name" forKey:@"fields"] HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id<FBGraphObject> result, NSError *error) {
		NSString *fbID = [result objectForKey:@"id"];
		NSString *firstName = [result objectForKey:@"first_name"];
		NSString *lastName = [result objectForKey:@"last_name"];
		NSDictionary *pictureDict = [result objectForKey:@"picture"];
		NSDictionary *pictureDataDict = [pictureDict objectForKey:@"data"];
		NSString *picture = [pictureDataDict objectForKey:@"url"];
		NSString *fbToken = [FBSession activeSession].accessTokenData.accessToken;
		callback(error, fbID, fbToken, picture, firstName, lastName);
	}];

}

+ (void)requestNameForFriend:(NSString *)friendID callback:(void (^)(NSError *error, NSString *firstName, NSString *lastName))callback
{
	[FBRequestConnection startWithGraphPath:@"friendID"
								 parameters:@{@"fields": @"first_name,last_name"}
								 HTTPMethod:@"GET"
						  completionHandler:^(FBRequestConnection *connection, id<FBGraphObject> result, NSError *error) {
		NSString *firstName = [result objectForKey:@"first_name"];
		NSString *lastName = [result objectForKey:@"last_name"];
		callback(error, firstName, lastName);
	}];
}

+ (BOOL)reestablishSession
{
	return [FBSession openActiveSessionWithAllowLoginUI:NO];
}

+ (NSString *)getFacebookToken
{
	return [FBSession activeSession].accessTokenData.accessToken;
}

@end
