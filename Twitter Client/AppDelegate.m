//
//  AppDelegate.m
//  Twitter Client
//
//  Created by William Seo on 2/16/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "ParentViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) ParentViewController *pvc;
@property (nonatomic, strong) MenuViewController *menuViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.333 green:0.675 blue:0.933 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    User *user = [User currentUser];
    [self initLoginViewController];
    [self initParentViewController];

    if (user != nil) {
        self.window.rootViewController = self.pvc;
    } else {
        NSLog(@"Not logged in");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initLoginViewController {
    if (!self.loginViewController) {
        self.loginViewController = [[LoginViewController alloc] init];
    } else {
        // Do nothing
    }
}

- (void)initParentViewController {
    TweetsViewController *tweetsViewController = [[TweetsViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];
    navigationController.navigationBar.translucent = NO;
    self.pvc = [[ParentViewController alloc] initWithMainViewController:navigationController];
    self.menuViewController = [[MenuViewController alloc] init];
    self.menuViewController.delegate = tweetsViewController;
    self.pvc.menuViewController = self.menuViewController;
}

- (void)userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}
 
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openURL:url];
    return YES;
}

@end
