//
//  MenuViewController.m
//  Twitter Client
//
//  Created by William Seo on 2/28/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "MenuViewController.h"
#import "User.h"
#import "MenuHeaderCell.h"
#import "ParentViewController.h"
#import <UIImageView+AFNetworking.h>

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSDictionary *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMenuItemsDictionary];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.clipsToBounds = YES;
    
    UINib *menuHeaderCellNib = [UINib nibWithNibName:@"MenuHeaderCell" bundle:nil];
    [self.tableView registerNib:menuHeaderCellNib forCellReuseIdentifier:@"MenuHeaderCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuItemCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMenuItemsDictionary {
    self.menuItems = @{
        @1 : @"Profile",
        @2 : @"Timeline",
        @3 : @"Mentions"
    };
}

#pragma mark - Table Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //make cell background clear; need to do it here because tableView won't do clear cells in cellForRowAtIndexPath
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        User *currentUser = [User currentUser];
        MenuHeaderCell *menuHeadercell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuHeaderCell"];
        menuHeadercell.nameLabel.text = currentUser.name;
        [menuHeadercell.profileImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
        return menuHeadercell;
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuItemCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.menuItems objectForKey:[NSNumber numberWithInteger:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 105;
    }
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // Do nothing
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate didSelectMenuItem:indexPath.row];
        [(ParentViewController *)self.pvc hideMenu];
    }
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
