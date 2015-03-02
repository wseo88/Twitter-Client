//
//  ProfileViewController.m
//  Twitter Client
//
//  Created by William Seo on 2/28/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "ProfileViewController.h"
#import "TweetCell.h"
#import "TweetDetailsViewController.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>

@interface ProfileViewController ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bannerImageView setImageWithURL:[NSURL URLWithString:self.user.bannerImageUrl]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    
    self.tweetsCountLabel.text = self.user.tweetsCount;
    self.followingCountLabel.text = self.user.followingCount;
    self.followersCountLabel.text = self.user.followersCount;

    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
