//
//  MainMenuViewController.m
//  LoginToboggan
//
//  Created by Kelson Hootman on 11/18/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import "MainMenuViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UIUtil.h"
#import "MobageHelper.h"
#import "FacebookHelper.h"

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateUIComponents];
}

- (void)updateUIComponents
{
	self.connectButton.hidden = [FBSession activeSession].isOpen;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)facebookConnect:(id)sender
{
	[FacebookHelper loginWithCallback:^(NSError *error) {
		if (error) {
			NSLog(@"An error occured during user login: %@",error);
			[FacebookHelper logOut]; // Just to be safe.
		} else {
			[FacebookHelper requestUserInfoWithCallback:^(NSError *error, NSString *fbID, NSString *fbToken, NSString *picture, NSString *firstName, NSString *lastName) {
				if (error) {
					NSLog(@"An error occured during user login: %@",error);
				} else {
					
					[self doFacebookUpgradeWithFacebookID:fbID facebookToken:fbToken pictureLocation:picture firstName:firstName lastName:lastName callback:^{
						// TODO continue removing this state machine stuff
						NSString *segueName = [[UIState sharedInstance] getAppropriateSegue];
						if (![segueName isEqualToString:@"goToMainMenu"]) {
							[self performSegueWithIdentifier:segueName sender:nil];
						} else {
							self.connectButton.hidden = YES;
						}
					}];
					
				}
			}];
		}
	}];
}

- (void)doFacebookUpgradeWithFacebookID:(NSString *)fbID
						  facebookToken:(NSString *)fbToken
						pictureLocation:(NSString *)picture
							  firstName:(NSString*)firstName
							   lastName:(NSString *)lastName
							   callback:(void (^)())completeCb
{
	[MobageHelper upgradeWithFacebookID:fbID facebookToken:fbToken pictureLocation:picture firstName:firstName lastName:lastName callback:^(MBCancelableAPIStatus status, NSObject<MBError> *error){
		switch (status){
			case MBCancelableAPIStatusError:
				NSLog(@"An error occured during user login: %@",error);
				showHorribleErrorDialog();
				break;
			case MBCancelableAPIStatusCancel:
				[[[UIAlertView alloc] initWithTitle:@"FAIL" message:@"Something went wrong associating your facebook ID with Mobage, it may already be in use." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
				[FacebookHelper logOut];
				break;
			case MBCancelableAPIStatusSuccess:
			default:
				NSLog(@"User login success.");
				self.connectButton.hidden = YES;
				break;
		}
	}];

}

- (IBAction)logOut:(id)sender
{
	[FacebookHelper logOut];
	[MobageHelper logoutWithCallback:^(MBSimpleAPIStatus status, NSObject<MBError> *error) {
		if (status == MBSimpleAPIStatusSuccess) {
			[[UIState sharedInstance] reset];
			[self performSegueWithIdentifier:@"returnToLogin" sender:nil];
		} else {	
			[[[UIAlertView alloc] initWithTitle:@"FAIL" message:@"Cannot logout, most likely a guest user." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
	}];
}

// TODO: use community button image assets instead of text on the UIButton!
- (IBAction)showMobageCommunityUI:(id)sender
{
	[MBSocialService showCommunityUI];
}

@end
