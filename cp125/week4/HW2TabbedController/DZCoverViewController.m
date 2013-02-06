//
//  DZCoverViewController.m
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/20/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "DZCoverViewController.h"

@interface DZCoverViewController ()

@end

@implementation DZCoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"cover-did-receive-memory-warning");
    if ([self isBeingDismissed]) {
        NSLog(@"cover-is-being-dismissed");
    } else {
    
        void(^logCurlDismissedComplete)(void) = ^ {
            NSLog(@"cover-dismissed-complete");
            return;
        };
        [self dismissViewControllerAnimated:YES completion:logCurlDismissedComplete];
        // [self dismissCoverVerticalViewController:nil];

    }
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"cover-view-will-disappear");
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"cover-view-did-disappear");
    return;
}

- (IBAction)dismissCoverVerticalController:(UIButton *)sender {
    void (^showCoverVerticalComplete)(void) = ^{
        NSLog(@"DZCoverVerticalViewController down");
    };
    
    // showComplete();
    [self dismissViewControllerAnimated:YES completion:showCoverVerticalComplete];
}
@end
