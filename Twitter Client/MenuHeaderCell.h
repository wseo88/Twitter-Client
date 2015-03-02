//
//  MenuHeaderCell.h
//  Twitter Client
//
//  Created by William Seo on 2/28/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MenuHeaderCell : UITableViewCell

@property (nonatomic, strong) User *user;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end
