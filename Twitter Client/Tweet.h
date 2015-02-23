//
//  Tweet.h
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *idString;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

- (NSString *)getCreatedAtTimeInterval;

@end
