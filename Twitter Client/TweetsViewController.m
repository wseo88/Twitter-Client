//
//  TweetsViewController.m
//  Twitter Client
//
//  Created by William Seo on 2/21/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "NewTweetViewController.h"
#import "TweetDetailsViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetCell"];
    
    self.navigationItem.title = @"Recent Tweets";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    UIImage *composeButtonImage = [UIImage imageNamed:@"compose.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:composeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onPostNew)];

    self.currentUser = [User currentUser];
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:1];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLogout {
    [User logout];
}

- (void)onPostNew {
    NewTweetViewController *vc = [[NewTweetViewController alloc] init];
    vc.user = self.currentUser;
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onRefresh {
    [self loadTweets];
}

- (void)loadTweets {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
        [self.tableView reloadData];
    }];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    [cell.tweet getCreatedAtTimeInterval];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    [cell layoutSubviews];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Delegations

- (void)didComposeNewTweet:(Tweet *)tweet {
    self.tweets = [[NSMutableArray alloc] initWithArray:[@[tweet] arrayByAddingObjectsFromArray:self.tweets]];
    [self.tableView reloadData];
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
