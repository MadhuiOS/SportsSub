//
//  DUDBManager.h

//
//  Created by kalyan on 8/22/14.

//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "UserProfile.h"
#import "Sports.h"
#import "Proficiency.h"

@interface SSDBManager : NSObject
{

}

#pragma mark - Core methods

/* get shared instance */
+(id)sharedInstance;

/* get managed object context*/
+(NSManagedObjectContext *)getContext;

/* saving object context*/
+(BOOL)saveContext;

#pragma mark - User profile

/* saving user profile */
-(void)saveUserProfile:(id)dataDict;

#pragma mark Default data

/* save application default data  */
-(void)saveSportsList:(id)defaultData;
-(void)saveProfiencyList:(id)defaultData;

-(NSArray *)getDBSportsList;
-(NSArray *)getDBProfiencyList;

+(UserProfile *)getDBUserProfile;


@end
