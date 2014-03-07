//
//  MobageHelper.m
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/10/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import "MobageHelper.h"

@implementation MobageHelper

+ (void) reestablishSessionWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBSocialService executeLoginWithKeys:@[@"LOGIN_TYPE"] values:@[@"establish_session"] withCallbackQueue:dispatch_get_main_queue() onComplete:completeCb];
}

+ (void)loginWithFacebookID:(NSString *)facebookID
              facebookToken:(NSString *)facebookToken
            pictureLocation:(NSString *)pictureLocation
                  firstName:(NSString *)firstName
                   lastName:(NSString *)lastName
                   callback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBSocialService executeLoginWithKeys:@[@"LOGIN_TYPE",@"FACEBOOK_ID",@"FACEBOOK_TOKEN", @"FIRST_NAME", @"LAST_NAME", @"PHOTO"]
								   values:@[@"facebook", facebookID, facebookToken, firstName, lastName, pictureLocation]
						withCallbackQueue:dispatch_get_main_queue()
							   onComplete:completeCb];
}

+ (void) loginAsGuestWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBSocialService executeLoginWithKeys:@[@"LOGIN_TYPE"] values:@[@"guest"] withCallbackQueue:dispatch_get_main_queue() onComplete:completeCb];
}

+ (void) loginWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBSocialService executeLoginWithKeys:@[@"LOGIN_TYPE"] values:@[@"mobage"] withCallbackQueue:dispatch_get_main_queue() onComplete:completeCb];
}

+ (void) logoutWithCallback:(void (^)(MBSimpleAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBSocialService executeLogoutWithCallbackQueue:dispatch_get_main_queue() onComplete:completeCb];
}

+ (void)upgradeWithFacebookID:(NSString *)facebookID
                facebookToken:(NSString *)facebookToken
              pictureLocation:(NSString *)pictureLocation
                    firstName:(NSString *)firstName
                     lastName:(NSString *)lastName
                     callback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
{
	[MBAuth executeUserUpgradeWithKeys:@[@"UPGRADE_TYPE",@"FACEBOOK_ID",@"FACEBOOK_TOKEN", @"FIRST_NAME", @"LAST_NAME", @"PHOTO"]
								values:@[@"facebook", facebookID, facebookToken, firstName, lastName, pictureLocation]
					 withCallbackQueue:dispatch_get_main_queue()
							onComplete:completeCb];
}

@end
