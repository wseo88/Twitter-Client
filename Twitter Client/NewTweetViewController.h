//
//  NewTweetViewController.h
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

extern NSInteger const kMaxCharacterCount;

@class NewTweetViewController;

@protocol NewTweetViewControllerDelegate <NSObject>

- (void)didComposeNewTweet:(Tweet *)tweet;

@end

@interface NewTweetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Tweet *replyTargetTweet;

@property (nonatomic, weak) id <NewTweetViewControllerDelegate> delegate;

@end