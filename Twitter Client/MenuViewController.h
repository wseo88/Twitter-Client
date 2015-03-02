//
//  MenuViewController.h
//  Twitter Client
//
//  Created by William Seo on 2/28/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

- (void)didSelectMenuItem:(NSInteger)selectedRow;

@end

@interface MenuViewController : UIViewController

@property (nonatomic) UIViewController *pvc;

@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
