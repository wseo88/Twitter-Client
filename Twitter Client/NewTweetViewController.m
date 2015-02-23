//
//  NewTweetViewController.m
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "NewTweetViewController.h"

#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>

NSInteger const kMaxCharacterCount = 140;

@interface NewTweetViewController () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *characterCountLabel;
@property (nonatomic, strong) UIBarButtonItem *tweetButton;

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTextView.delegate = self;

    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenname];
    
    if (self.replyTargetTweet) {
        self.title = @"Reply";
        NSString *prefixText = [NSString stringWithFormat:@"@%@", self.replyTargetTweet.user.screenname ];
        self.tweetTextView.text = prefixText;
    } else {
        self.title = @"New Tweet";
        self.tweetTextView.text = @"";
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    
    [self.tweetTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweet:(id)sender {
    NSDictionary *params = @{@"status": self.tweetTextView.text};
    NSMutableDictionary *paramsCopy = [params mutableCopy];
    
    if (self.replyTargetTweet) {
        paramsCopy[@"in_reply_to_status_id"] = self.replyTargetTweet.idString;
    } else {
        // Composing a new tweet
    }
    
    [[TwitterClient sharedInstance] composeNewTweet:paramsCopy completion:^(Tweet *tweet, NSError *error) {
        [self.delegate didComposeNewTweet:tweet];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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