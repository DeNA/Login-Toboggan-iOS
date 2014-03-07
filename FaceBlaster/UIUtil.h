//
//  UIUtil.h
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/4/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIState : NSObject
{
	BOOL loginIncentiveShown;
	BOOL inviteeIncentiveShown;
	BOOL nameInputShown;
}

+ (UIState *) sharedInstance;

- (NSString *) getAppropriateSegue;

- (void) reset;

@end

void showHorribleErrorDialog();
void alert(NSString *text, ...);
