//
//  DZFlipViewController.m
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/20/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "DZFlipViewController.h"

@interface DZFlipViewController ()

@end

@implementation DZFlipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
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
    NSLog(@"flip-did-receive-memory-warning");
    if ([self isBeingDismissed]) {
        NSLog(@"flip-is-being-dismissed");
    } else {
    
        void(^logCurlDismissedComplete)(void) = ^ {
            NSLog(@"flip-dismissed-complete");
            return;
        };
        [self dismissViewControllerAnimated:YES completion:logCurlDismissedComplete];
        
        // [self dismissFlipHorizontal:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"flip-view-will-disappear");
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"flip-view-did-disappear");
    return;
}

- (IBAction)dismissFlipHorizontal:(UIButton *)sender {
    NSLog(@"CrossViewController.dismissFlipHorizontal");
    void (^showComplete)(void) = ^{
        NSLog(@"DZFlipViewController down");
    };
    
    // showComplete();
    [self dismissViewControllerAnimated:YES completion:showComplete];

}
@end
