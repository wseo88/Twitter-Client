//
//  TweetCell.m
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapProfileImage:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    self.profileImageView.userInteractionEnabled = YES;
    [self.profileImageView addGestureRecognizer:tapGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrl]];
    self.nameLabel.text = _tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", _tweet.user.screenname];
    self.createdAtLabel.text = [_tweet getCreatedAtTimeInterval];
    self.tweetTextLabel.text = _tweet.text;
}

- (void)onTapProfileImage:(UIGestureRecognizer *)gestureRecognizer {
    [self.delegate didTapProfileImage:self.tweet.user];
}

@end
