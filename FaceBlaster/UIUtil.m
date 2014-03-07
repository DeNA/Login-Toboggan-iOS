//
//  UIUtil.m
//  LoginToboggan
//
//  Created by Kelson Hootman on 12/4/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import "UIUtil.h"

@implementation UIState

+ (UIState *)sharedInstance {
	static UIState *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIState alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAppropriateSegue
{
	return @"goToMainMenu";
}

- (void)reset
{
	loginIncentiveShown = NO;
	inviteeIncentiveShown = NO;
	nameInputShown = NO;
}
@end


void showHorribleErrorDialog() {
	[[[UIAlertView alloc] initWithTitle:@"FAIL" message:@"Something went horribly wrong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

// Part of me is sorry this is here. Another part is happy to type less.
void alert(NSString *text, ...) {
	va_list args;
	va_start(args, text);
	NSString *msg = [[NSString alloc] initWithFormat:text arguments:args];
	[[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
