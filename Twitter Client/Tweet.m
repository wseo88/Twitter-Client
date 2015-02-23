//
//  Tweet.m
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.idString = dictionary[@"id_str"];
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictioanry in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictioanry]];
    }
    return tweets;
}

- (NSString *)getCreatedAtTimeInterval {
    NSDate *date= [NSDate date];
    NSTimeInterval diff = [date timeIntervalSinceDate:self.createdAt];
    NSString *createdAtTimeInterval;
    if ((int)diff/3600 < 24) {
        createdAtTimeInterval = [NSString stringWithFormat:@"%dh", (int)diff/3600];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yy"];
        createdAtTimeInterval = [formatter stringFromDate:self.createdAt];
    }
    return createdAtTimeInterval;
}

@end
