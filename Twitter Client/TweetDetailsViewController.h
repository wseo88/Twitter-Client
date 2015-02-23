//
//  TweetDetailsViewController.h
//  Twitter Client
//
//  Created by William Seo on 2/22/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (nonatomic, strong) Tweet *tweet;

@end
