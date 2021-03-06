//
//  AppDelegate.h
//  SportsSub
//
//  Created by Kalyan Varma on 23/10/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LocationGetter.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,LocationGetterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UITabBarController *tabBarController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)createTabbar;
-(void)CurrentLocationUpdate;
@end

