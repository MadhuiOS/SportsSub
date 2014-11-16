//
//  FavouritieViewController.m
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "FavouritieViewController.h"
#import "FavoritiesTableViewCell.h"

@interface FavouritieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblFavorite;

@end

@implementation FavouritieViewController

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
    [self setTitle:@"FAVOURITE"];
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



#pragma Table View
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"LeadersCell";
    FavoritiesTableViewCell *cell=(FavoritiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FavoritiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    //  Tweets *tweet=[[[Content shared] leaderTweets] objectAtIndex:indexPath.row];
    
    [cell updateCell:self];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
