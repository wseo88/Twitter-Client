//
//  TweetDetailsViewController.m
//  Twitter Client
//
//  Created by William Seo on 2/22/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "NewTweetViewController.h"
#import <UIImageView+AFNetworking.h>

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.nameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
    self.tweetTextLabel.text = self.tweet.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd/yy, hh:mm a"];
    
    self.createdAtLabel.text = [formatter stringFromDate:self.tweet.createdAt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReply:(id)sender {
    NewTweetViewController *vc = [[NewTweetViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.user = [User currentUser];
    vc.replyTargetTweet = self.tweet;
    [self presentViewController:nvc animated:YES completion:nil];
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
