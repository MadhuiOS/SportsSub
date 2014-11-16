//
//  HomeViewControllerTableViewCell.h
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInvitation.h"

@protocol HomeViewControllerTableViewCellDelegate<NSObject>

-(void)acceptInvitation:(NSString *)invitationId;
-(void)rejectInvitation:(NSString *)invitationId;

@end


@interface HomeViewControllerTableViewCell : UITableViewCell

{

}

@property(nonatomic,weak) id<HomeViewControllerTableViewCellDelegate> delegate;

-(void)updateCell:(UserInvitation *)userInv;
@end
