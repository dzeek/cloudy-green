//
//  DZCrossViewController.m
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/20/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "DZCrossViewController.h"

@interface DZCrossViewController ()

@end

@implementation DZCrossViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
    NSLog(@"cross-did-receive-memory-warning");
    if ([self isBeingDismissed]) {
        NSLog(@"cross-is-being-dismissed");
    } else {
    
        void(^logCrossDismissedComplete)(void) = ^ {
            NSLog(@"cross-dismissed-complete");
            return;
        };
        [self dismissViewControllerAnimated:YES completion:logCrossDismissedComplete];
        // [self dismissFlipHorizontal:nil];

    }
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"cross-view-will-disappear");
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"cross-view-did-disappear");
    return;
}


- (IBAction)dismissCrossView:(id)sender {
    NSLog(@"CrossViewController.dismissCrossView");
    void (^showComplete)(void) = ^{
        NSLog(@"DZCrossViewController down");
    };
    
    // showComplete();
    [self dismissViewControllerAnimated:YES completion:showComplete];
}
@end
