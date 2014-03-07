//
//  FacebookHelper.h
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/10/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookHelper : NSObject

+ (void)loginWithCallback:(void (^)(NSError * error))callback;
+ (void)logOut;
+ (void)requestUserInfoWithCallback:(void (^)(NSError *error, NSString *fbID, NSString *fbToken, NSString *picture, NSString *firstName, NSString *lastName))callback;
+ (void)requestNameForFriend: (NSString *)friendID callback:(void (^)(NSError *error, NSString *firstName, NSString *lastName))callback;
+ (BOOL)reestablishSession;
+ (NSString *)getFacebookToken;

@end
