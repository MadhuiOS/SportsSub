//
//  HomeViewController.m
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewControllerTableViewCell.h"
#import "FindPlayerMapViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"
#import "UserDefaultsHelper.h"
@interface HomeViewController ()<HomeViewControllerTableViewCellDelegate>
{
    NSMutableArray *arrContent;
}
@property (weak, nonatomic) IBOutlet UITableView *tblFindPlayer;
@property (weak, nonatomic) IBOutlet UIButton *btnFindPlayer;

- (IBAction)clickedFindPlayerButton:(id)sender;
-(void)receivedAllInvitations;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    

    [super viewWillAppear:animated];
    [self setTitle:@"HOME"];
    
    [self receivedAllInvitations];

}
-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
        [self setTitle:@""];
    
 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Table View
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrContent count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"LeadersCell";
    HomeViewControllerTableViewCell *cell=(HomeViewControllerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomeViewControllerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
//    UserInvitation *userInv=[arrContent objectAtIndex:indexPath.row];
//    
//    [cell updateCell:userInv];
//    cell.delegate=self;
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}


-(void)receivedAllInvitations
{

    [Utilities showProgressView:self.view];
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@%@",DUINVITEURL,[UserDefaultsHelper getStringForKey:@"userid"]] requestType:@"POST" requestrequestData:nil WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        NSLog(@"%@",[[response objectForKey:@"content"] objectForKey:@"receivedRequestList"]);
         NSLog(@"%@",[errorOrNil description]);
        
        
        [arrContent removeAllObjects];
         arrContent=nil;
        [Utilities hideProgressView];
         arrContent=[[NSMutableArray alloc] init];
         arrContent=[response mutableCopy];

         [_tblFindPlayer reloadData];

         [Utilities hideProgressView];
        
    }];
    

    
//        [content getAllReceivedInvitations:@"94" WithBlock:^(NSArray *query, NSError *errorOrNil)
//     {
//         [arrContent removeAllObjects];
//         arrContent=nil;
//         
//         arrContent=[[NSMutableArray alloc] init];
//         arrContent=[query mutableCopy];
//         
//         [_tblFindPlayer reloadData];
//         
//         [Utilities hideProgressView];
//     }];
    
}

#pragma HomeViewController TableView Cell Delegates

-(void)acceptInvitation:(NSString *)invitationId
{
 
    NSDictionary *paramsDict = @{@"invite_id":@"",@"accept":@"1"};
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@acceptInvitation",DUURL] requestType:@"POST" requestrequestData:paramsDict WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
              [self receivedAllInvitations];
        
    }];
    
}
-(void)rejectInvitation:(NSString *)invitationId
{
    
    NSDictionary *paramsDict = @{@"invite_id":@"",@"reject":@"1"};
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@rejectInvitation",DUURL] requestType:@"POST" requestrequestData:paramsDict WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        [self receivedAllInvitations];
        
    }];
    
}


- (IBAction)clickedFindPlayerButton:(id)sender
{
    NSLog(@"Clicked Find Player Map Button ....");
    
    FindPlayerMapViewController *fpMapVC=[[FindPlayerMapViewController alloc] initWithNibName:@"FindPlayerMapViewController" bundle:nil];
    [self.navigationController pushViewController:fpMapVC animated:YES];
}
@end
