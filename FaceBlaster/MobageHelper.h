//
//  MobageHelper.h
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/10/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobageNDK/MobageNDK.h>

@interface MobageHelper : NSObject

+ (void)reestablishSessionWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb;
+ (void)loginWithFacebookID:(NSString *)facebookID
              facebookToken:(NSString *)facebookToken
            pictureLocation:(NSString *)pictureLocation
                  firstName:(NSString *)facebookID
                   lastName:(NSString *)facebookID
                   callback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb;
+ (void)loginAsGuestWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb;
+ (void)loginWithCallback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb;
+ (void)logoutWithCallback:(void (^)(MBSimpleAPIStatus status, NSObject<MBError> *error))completeCb;
+ (void)upgradeWithFacebookID:(NSString *)facebookID
                facebookToken:(NSString *)facebookToken
              pictureLocation:(NSString *)pictureLocation
                    firstName:(NSString *)firstName
                     lastName:(NSString *)lastName
                     callback:(void (^)(MBCancelableAPIStatus status, NSObject<MBError> *error))completeCb
;

@end
