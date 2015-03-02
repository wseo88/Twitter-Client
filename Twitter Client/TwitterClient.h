//
//  TwitterClient.h
//  Twitter Client
//
//  Created by William Seo on 2/16/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)getMentions:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)composeNewTweet:(NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion;

@end
