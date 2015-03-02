//
//  ParentViewController.h
//  Twitter Client
//
//  Created by William Seo on 3/1/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface ParentViewController : UIViewController

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;

- (id)initWithMainViewController:(UIViewController *)mainViewController;
- (void)hideMenu;

@end
