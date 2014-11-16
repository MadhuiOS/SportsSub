//
//  LogInViewController.h
//  SportsSub
//
//  Created by Home on 8/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface LogInViewController : UIViewController<FBLoginViewDelegate>
@property(nonatomic,strong) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@end
