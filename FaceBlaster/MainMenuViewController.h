//
//  MainMenuViewController.h
//  LoginToboggan
//
//  Created by Kelson Hootman on 11/18/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *connectButton;

@property (nonatomic, weak) IBOutlet UILabel *welcomeLabel;

- (IBAction)facebookConnect:(id)sender;

- (IBAction)logOut:(id)sender;

- (IBAction)showMobageCommunityUI:(id)sender;

@end
