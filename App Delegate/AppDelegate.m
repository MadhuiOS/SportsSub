//
//  AppDelegate.m
//  SportsSub
//
//  Created by Home on 8/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "FavouritieViewController.h"
#import "FilterFindPlayerViewController.h"    // Not Finished
#import "EditProfileViewController.h"
#import "PublicProfileViewController.h"
#import "SendInviteViewController.h"
#import "AboutUsViewController.h"
#import "SSNetworkManager.h"
#import "SSDBManager.h"
#import "UserDefaultsHelper.h"
#import "Utilities.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    if (![CLLocationManager locationServicesEnabled]) {
        // location services is disabled, alert user
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DisabledTitle", @"DisabledTitle")
                                                                        message:NSLocalizedString(@"DisabledMessage", @"DisabledMessage")
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", @"OKButtonTitle")
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    [self CurrentLocationUpdate];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
  
    if (TARGET_IPHONE_SIMULATOR)
    {
        //Running on simulator
    }else
    {
        //-- Set Notification
        if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            
            [application registerForRemoteNotifications];
        }
        else
        {
            // iOS < 8 Notifications
            [application registerForRemoteNotificationTypes:
             (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        }
        //Real one
    }

    
    
//    SplashViewController *sVC=[[SplashViewController alloc]initWithNibName:@"SplashViewController" bundle:nil];
//    [self.window setRootViewController:sVC];
    
    
    if ([[[SSDBManager sharedInstance] getDBSportsList] count]==0)
    {
        [[SSNetworkManager sharedInstance] fetchSportsList];
    }

    
    if ([UserDefaultsHelper getBoolForKey:@"userlogin"])
    {
        [self createTabbar];
    }
    else
    {
        LogInViewController *lVC=[[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
        [self.window setRootViewController:lVC];
    }
    
  //  [self performSelector:@selector(createTabbar) withObject:nil afterDelay:2.0];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)createTabbar
{
    
    AboutUsViewController * avc = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    
    HomeViewController * hvc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    
    FavouritieViewController * fvc = [[FavouritieViewController alloc] initWithNibName:@"FavouritieViewController" bundle:nil];
    
    
    PublicProfileViewController * ppvc = [[PublicProfileViewController alloc] initWithNibName:@"PublicProfileViewController" bundle:nil];
    
    
    
    SendInviteViewController * ivc = [[SendInviteViewController alloc] initWithNibName:@"SendInviteViewController" bundle:nil];
    
    
    UINavigationController *nc1=[[UINavigationController alloc] initWithRootViewController:avc];
    UINavigationController *nc2=[[UINavigationController alloc] initWithRootViewController:hvc];
    UINavigationController *nc3=[[UINavigationController alloc] initWithRootViewController:fvc];
    UINavigationController *nc4=[[UINavigationController alloc] initWithRootViewController:ppvc];
    UINavigationController *nc5=[[UINavigationController alloc] initWithRootViewController:ivc];
    
    
    [nc1.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [nc2.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [nc3.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [nc4.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [nc5.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.tabBarController=[[UITabBarController alloc] init];
    self.tabBarController.viewControllers=@[nc1,nc2,nc3,nc4,nc5];

    //    [[self.tabBarController.tabBar appearance] setTintColor:[UIColor redColor]];
    
    //  self.window.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:(32.0/255.0) green:(32.0/255.0) blue:(32.0/255.0) alpha:1.0];
    
    
    UITabBar *tabBar =  self.tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    
    [tabBarItem1 setTitlePositionAdjustment:UIOffsetMake(0.0, 50.0)];
    [tabBarItem2 setTitlePositionAdjustment:UIOffsetMake(0.0, 50.0)];
    [tabBarItem3 setTitlePositionAdjustment:UIOffsetMake(0.0, 50.0)];
    [tabBarItem4 setTitlePositionAdjustment:UIOffsetMake(0.0, 50.0)];
    [tabBarItem5 setTitlePositionAdjustment:UIOffsetMake(0.0, 50.0)];
    
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"tab_about_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_about.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"tab_home_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_home.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"tab_favorite_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_favorite.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"tab_profile_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_profile.png"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"tab_invite_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_invite.png"]];
    
    [self.tabBarController setSelectedIndex:0];
    
    

    [self.window setRootViewController:self.tabBarController];
    
    
    /*
     
     //  UIEdgeInsets imageInset = UIEdgeInsetsMake(7, 0, -7, 0);
     AboutUsViewController * avc = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
     //  avc.title=@"ABOUT US";
     UINavigationController *nc1=[[UINavigationController alloc] initWithRootViewController:avc];
     [nc1.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
     
     //  nc1.tabBarItem.image=[UIImage imageNamed:@"tab_about.png"];
     //  [nc1.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_about_on.png"]];
     [nc1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_about_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_about.png"] ];
     //  nc1.tabBarItem.imageInsets = imageInset;
     
     //  [nc1.navigationBar setTintColor:[UIColor colorWithRed:(3.0/255.0) green:(192.0/255.0) blue:(60.0/255.0) alpha:1.0]]; //setBackgroundColor:[UIColor colorWithRed:(3.0/255.0) green:(192.0/255.0) blue:(60.0/255.0) alpha:1.0]];
     
     
     
     HomeViewController * hvc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
     //   hvc.title=@"HOME";
     UINavigationController *nc2=[[UINavigationController alloc] initWithRootViewController:hvc];
     //  [nc2.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
     
     // nc2.tabBarItem.image=[UIImage imageNamed:@"tab_home.png"];
     // [nc2.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_home_on.png"]];
     
     [nc2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_home_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_home.png"] ];
     // nc2.tabBarItem.imageInsets = imageInset;
     
     
     
     FavouritieViewController * fvc = [[FavouritieViewController alloc] initWithNibName:@"FavouritieViewController" bundle:nil];
     //  fvc.title=@"FAVORITE";
     UINavigationController *nc3=[[UINavigationController alloc] initWithRootViewController:fvc];
     [nc3.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
     
     //  nc3.tabBarItem.image=[UIImage imageNamed:@"tab_favorite.png"];
     //  [ nc3.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_favorite_on.png"]];
     
     [nc3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_favorite_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_favorite.png"] ];
     //   nc3.tabBarItem.imageInsets = imageInset;
     
     PublicProfileViewController * ppvc = [[PublicProfileViewController alloc] initWithNibName:@"PublicProfileViewController" bundle:nil];
     // ppvc.title=@"EDIT PROFILE";
     UINavigationController *nc4=[[UINavigationController alloc] initWithRootViewController:ppvc];
     [nc4.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
     
     //   nc4.tabBarItem.image=[UIImage imageNamed:@"tab_profile.png"];
     //  [  nc4.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_profile_on.png"]];
     
     [nc4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_profile_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_profile.png"] ];
     // nc4.tabBarItem.imageInsets = imageInset;
     
     
     SendInviteViewController * ivc = [[SendInviteViewController alloc] initWithNibName:@"SendInviteViewController" bundle:nil];
     // ivc.title=@"Invite";
     UINavigationController *nc5=[[UINavigationController alloc] initWithRootViewController:ivc];
     [nc5.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
     //   nc5.tabBarItem.image=[UIImage imageNamed:@"tab_invite.png"];
     //   [nc5.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_invite_on.png"]];
     [nc5.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_invite_on.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_invite.png"] ];
     //  nc5.tabBarItem.imageInsets = imageInset;
     
     self.tabBarController=[[UITabBarController alloc] init];
     self.tabBarController.viewControllers=@[nc1,nc2,nc3,nc4,nc5];
     
     LogInViewController *lVC=[[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
     [self.window setRootViewController:lVC];
     
     */
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{

    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    [UserDefaultsHelper setStringValue:token forKey:@"devicetoken"];
    
   NSDictionary *dictParam=@{@"devicetoken":token,@"message":@"kalyan apns test"};

    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        
    }];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SportsSub" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SportsSub.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

# pragma mark - LocationGetter Delegate Methods

- (void)newPhysicalLocation:(CLLocation *)location {
    
    NSLog(@"%@",location);
    // Alert user
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Found" message:[NSString stringWithFormat:@"Found physical location.  %f %f",location.coordinate.latitude, location.coordinate.longitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}
-(void)CurrentLocationUpdate{
    LocationGetter *locationGetter = [[LocationGetter alloc] init];
    locationGetter.delegate = self;
    [locationGetter startUpdates];
}

@end
