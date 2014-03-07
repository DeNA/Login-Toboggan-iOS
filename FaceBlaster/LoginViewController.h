//
//  LoginViewController.h
//  LoginToboggan
//
//  Created by Kelson Hootman on 11/14/13.
//  Copyright (c) 2013 ngmoco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIButton *facebookLoginButton;
@property (nonatomic, weak) IBOutlet UIButton *guestLoginButton;
@property (nonatomic, weak) IBOutlet UIButton *mobageLoginButton;

- (IBAction)facebookConnect:(id)sender;

- (IBAction)skipLogin:(id)sender;

- (IBAction)mobageLogin:(id)sender;

@end
