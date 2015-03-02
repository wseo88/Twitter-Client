//
//  ParentViewController.m
//  Twitter Client
//
//  Created by William Seo on 3/1/15.
//  Copyright (c) 2015 William Seo. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()

@property (nonatomic) BOOL isMenuDisplayed;

@end

@implementation ParentViewController

- (id)initWithMainViewController:(UIViewController *)mainViewController {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.mainViewController = mainViewController;
        self.isMenuDisplayed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.mainViewController.view];
    [self.view insertSubview:self.menuViewController.view belowSubview:self.mainViewController.view];
    self.menuViewController.pvc = self;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    [self.mainViewController.view addGestureRecognizer:panRecognizer];
    self.mainViewController.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegations

- (void)onPanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // translate the content view controller based on the pan
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        self.mainViewController.view.center = CGPointMake(MAX(self.mainViewController.view.center.x + translation.x, self.view.center.x), self.mainViewController.view.center.y);
        [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self toggleMenu];
    }
}

- (void)toggleMenu {
    if (self.isMenuDisplayed) {
        [self hideMenu];
    } else {
        [self displayMenu];
    }
}

- (void)displayMenu {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainViewController.view.frame = CGRectMake(self.view.frame.size.width - 25, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        self.isMenuDisplayed = YES;
    }];
}

- (void)hideMenu {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainViewController.view.frame = self.view.frame;
    } completion:^(BOOL finished) {
        self.isMenuDisplayed = NO;
    }];
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
