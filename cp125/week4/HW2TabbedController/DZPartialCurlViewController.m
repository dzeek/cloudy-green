//
//  DZPartialCurlViewController.m
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/20/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "DZPartialCurlViewController.h"

@interface DZPartialCurlViewController ()

@end

@implementation DZPartialCurlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
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
    NSLog(@"partialcurl-did-receive-memory-warning");
    if ([self isBeingDismissed]) {
        NSLog(@"partialcurl-is-being-dismissed");
    } else {
    
        void(^logCurlDismissedComplete)(void) = ^ {
            NSLog(@"partialcurl-dismissed-complete");
            return;
        };
        [self dismissViewControllerAnimated:YES completion:logCurlDismissedComplete];
        // [self dismissPartialCurl:nil];

    }
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"partialcurl-view-will-disappear");
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"partialcurl-view-did-disappear");
    return;
}

- (IBAction)dismissPartialCurl:(UIButton *)sender {
    void (^showPartialCurlComplete)(void) = ^{
        NSLog(@"DZpartialCurlViewController down");
    };
    
    // showComplete();
    [self dismissViewControllerAnimated:YES completion:showPartialCurlComplete];
}
@end
