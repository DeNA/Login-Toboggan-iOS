// 
//  LoginViewController.m
//  LoginToboggan
// 
//  Created by Kelson Hootman on 11/14/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
// 

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#include "Globals.h"
#import "UIUtil.h"
#import "MobageHelper.h"
#import "FacebookHelper.h"


@implementation LoginViewController

- (void)viewDidLoad
{
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		// Attempt to establish a session for Mobage without showing UI.
		[self showSpinner];
		self.facebookLoginButton.hidden = YES;
		self.guestLoginButton.hidden = YES;
		self.mobageLoginButton.hidden = YES;
		[MobageHelper reestablishSessionWithCallback:^(MBCancelableAPIStatus status, NSObject<MBError> *error) {
			[self hideSpinner];
			switch (status){
				case MBCancelableAPIStatusError:
					NSLog(@"An error occured during user login: %@",error);
					break;
				case MBCancelableAPIStatusCancel:
					// Unable to reestablish session, so show buttons allowing user to log in
					self.facebookLoginButton.hidden = NO;
					self.guestLoginButton.hidden = NO;
					self.mobageLoginButton.hidden = NO;
					NSLog(@"Unable to reestablish Mobage session.");
					break;
				case MBCancelableAPIStatusSuccess:
				default:
					NSLog(@"Mobage session reestablished.");
					// If the attempt succeeds, try to establish a session for Facebook with no UI as well
					if ([FacebookHelper reestablishSession]) {
						NSLog(@"Facebook session reestablished.");
					} else {
						NSLog(@"Unable to reestablish Facebook session.");
					}
					[self performSegueWithIdentifier:[[UIState sharedInstance] getAppropriateSegue] sender:nil];
					break;
			}
		}];
	});
	
    [super viewDidLoad];
}

- (IBAction)facebookConnect:(id)sender {
	// Log in to Facebook first
	[FacebookHelper loginWithCallback:^(NSError *error) {
		if (error) {
			NSLog(@"An error occured during user login: %@",error);
			// If it fails with an error, log out to prevent repeats of the same error...
			[FacebookHelper logOut];
			// ...and tell the user that something went wrong.
			showHorribleErrorDialog();
		} else {
			[self showSpinner];
			// If facebook login succeeds, get the user's information
			[FacebookHelper requestUserInfoWithCallback:^(NSError *error, NSString *fbID, NSString *fbToken, NSString *picture, NSString *firstName, NSString *lastName) {
				if (error) {
					// In case of error, log out of facebook and show the error dialog
					[FacebookHelper logOut];
					showHorribleErrorDialog();
					[self hideSpinner];
					NSLog(@"An error occured during user login: %@",error);
				} else {
					// Once we have the user's information, use it to log in to Mobage
					[MobageHelper loginWithFacebookID:fbID
										facebookToken:fbToken
									  pictureLocation:picture
											firstName:firstName
											 lastName:lastName
											 callback:^(MBCancelableAPIStatus status, NSObject<MBError> *error) {
						[self hideSpinner];
						switch (status){
							case MBCancelableAPIStatusError:
							case MBCancelableAPIStatusCancel: // Cancel is not possible
								// In case of error, log out of facebook and show the error dialog
								[FacebookHelper logOut];
								showHorribleErrorDialog();
								NSLog(@"An error occured during user login: %@",error);
								break;
							case MBCancelableAPIStatusSuccess:
							default:
								[self performSegueWithIdentifier:[[UIState sharedInstance] getAppropriateSegue] sender:nil];
								NSLog(@"User login success.");
								break;
						}
					}];
					
				}
			}];
		}
	}];
}

- (IBAction)skipLogin:(id)sender {
	// Skip is simple, just login to Mobage as a guest
	[self showSpinner];
	[MobageHelper loginAsGuestWithCallback:^(MBCancelableAPIStatus status, NSObject<MBError> *error) {
		[self hideSpinner];
        switch (status) {
            case MBCancelableAPIStatusError:
                NSLog(@"An error occured during user login: %@",error);
				// If there's an error, show the dialog and let the user try again
				showHorribleErrorDialog();
                break;
            case MBCancelableAPIStatusCancel:
                NSLog(@"User login cancelled.");
                break;
            case MBCancelableAPIStatusSuccess:
            default:
                NSLog(@"User login success.");
				[self performSegueWithIdentifier:[[UIState sharedInstance] getAppropriateSegue] sender:nil];
                break;
        }
    }];
}

- (IBAction)mobageLogin:(id)sender {
	// Because we're about to show Mobage UI, make sure that the Root View Controller is set correctly
	[UIApplication sharedApplication].keyWindow.rootViewController = self;
	[self showSpinner];
	// Show the Mobage Login UI
	[MobageHelper loginWithCallback:^(MBCancelableAPIStatus status, NSObject<MBError> *error) {
		[self hideSpinner];
        switch (status){
            case MBCancelableAPIStatusError:
				// If there's an error, show the dialog and let the user try again.
				showHorribleErrorDialog();
                NSLog(@"An error occured during user login: %@",error);
                break;
            case MBCancelableAPIStatusCancel:
                NSLog(@"User login cancelled.");
                break;
            case MBCancelableAPIStatusSuccess:
            default:
				[self performSegueWithIdentifier:[[UIState sharedInstance] getAppropriateSegue] sender:nil];
                NSLog(@"User login success.");
                break;
        }
    }];
}

- (void)showSpinner
{
	// In a real game, this would be a good time to pause rendering and/or release some resources
	self.facebookLoginButton.enabled = NO;
	self.guestLoginButton.enabled = NO;
	self.mobageLoginButton.enabled = NO;
	[self.activityIndicator startAnimating];
}

- (void)hideSpinner
{
	self.facebookLoginButton.enabled = YES;
	self.guestLoginButton.enabled = YES;
	self.mobageLoginButton.enabled = YES;
	[self.activityIndicator stopAnimating];
}

@end
