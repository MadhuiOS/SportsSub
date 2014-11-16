//

//

#import "SSDBManager.h"
#import "SSNetworkManager.h"

@implementation SSDBManager

static SSDBManager *sharedInstance=nil;


#pragma mark - Init Methods

+(id)sharedInstance
{
    @synchronized (self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [self new];
        }
    }
    return sharedInstance;
}

#pragma mark - CoreData Maintenance

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - Database core Methods

+(NSManagedObjectContext *)getContext
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return  appDelegate.managedObjectContext;
}

+(BOOL)saveContext
{
    NSError *error;
    if (![[SSDBManager getContext] save:&error])
    {
        return NO;
    }
    return YES;
}

+(NSManagedObject *)getManagedObject:(NSString *)type
{
    NSManagedObjectContext *context = [SSDBManager getContext];
    return [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:context];
}

+(NSFetchRequest *)getFetchRequestWithEntity:(NSString *)entity andOwnPredicate:(NSPredicate *)predicate
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:[SSDBManager getContext]] ;
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDescription];
    if(predicate)
    {
        [request setPredicate:predicate];
    }
    return request;
}

+(NSFetchRequest *)getFetchRequestWithEntity:(NSString *)entity andPredicate:(NSString *)predicate
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:[SSDBManager getContext]] ;
   // [NSManagedObjectModel entities];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDescription];
    if(predicate)
    {
        NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:predicate];
        [request setPredicate:fetchPredicate];
    }
    return request;
}

#pragma mark - saving data methods

-(void)saveSportsList:(id)defaultData
{
    
    for (NSDictionary *dict in defaultData)
    {
        Sports *sports =  (Sports *)[NSEntityDescription insertNewObjectForEntityForName:@"Sports" inManagedObjectContext:[SSDBManager getContext]];
        [sports setSportsId:[dict objectForKey:@"sportsId"]];
        [sports setSportsName:[dict objectForKey:@"sportsName"]];
        [SSDBManager saveContext];
    }
    
    if ([[[SSDBManager sharedInstance] getDBProfiencyList] count]==0)
    {
        [[SSNetworkManager sharedInstance] fetchProfiencyList];
    }
    
}
-(void)saveProfiencyList:(id)defaultData;
{
    for (NSDictionary *dict in defaultData)
    {
        
   Proficiency *profiency =  (Proficiency *)[NSEntityDescription insertNewObjectForEntityForName:@"Proficiency" inManagedObjectContext:[SSDBManager getContext]];
    [profiency setProficiencyId:[dict objectForKey:@"proficiencyId"]];
    [profiency setProficiencyLevel:[dict objectForKey:@"proficiencyLevel"]];
    [SSDBManager saveContext];
    }
}

-(void)saveUserProfile:(id)dataDict
{
    UserProfile *userProfile;
    NSError *error;
    NSManagedObjectID *editObjectID;
    if (userProfile)
    {
        editObjectID = [userProfile objectID];
        userProfile = (UserProfile *)[[SSDBManager getContext]
                                  existingObjectWithID:editObjectID
                                  error:&error];
    }
    else
    {
        userProfile =  (UserProfile *)[NSEntityDescription insertNewObjectForEntityForName:@"UserProfile" inManagedObjectContext:[SSDBManager getContext]];
    }
    
    
    [userProfile setUserDOB:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"userDOB"]]];
    [userProfile setUserEmail:[dataDict objectForKey:@"userEmail"]];
    [userProfile setUserFacebookId:[dataDict objectForKey:@"userFacebookId"]];
    [userProfile setUserTwitterId:[dataDict objectForKey:@"userTwitterId"]];
    [userProfile setUserFirstName:[dataDict objectForKey:@"userEmail"]];
    [userProfile setUserImage:[dataDict objectForKey:@"userImage"]];
    [userProfile setUserThumbImage:[dataDict objectForKey:@"userThumbImage"]];
    [userProfile setUserLongitude:[dataDict objectForKey:@"userLatitude"]];
    [userProfile setUserLatitude:[dataDict objectForKey:@"userLongitude"]];
    [userProfile setUserLastName:[dataDict objectForKey:@"userLastName"]];
    [userProfile setUserId:[dataDict objectForKey:@"userId"]];
    [userProfile setUserGender:[dataDict objectForKey:@"userGender"]];

    [SSDBManager saveContext];
}

+(UserProfile *)getDBUserProfile
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"UserProfile" andPredicate:nil] error:&error];
    return [array lastObject];
}
#pragma mark - fetch  database methods

-(NSArray *)getDBSportsList
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"Sports" andPredicate:nil] error:&error];
    return array;
}
-(NSArray *)getDBProfiencyList
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"Proficiency" andPredicate:nil] error:&error];
    return array;
}


@end
