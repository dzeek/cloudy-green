//
//  Z2HSecondEmptyViewController.m
//  HW2TabbedController
//
//  Created by Don Zeek on 2/3/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import "Z2HSecondEmptyViewController.h"

@interface Z2HSecondEmptyViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIButton *noactionButton;

@property (nonatomic, strong) UILabel *portraitLabel;

@property (nonatomic, strong) NSArray *horizontalConstraints;
@property (nonatomic, strong) NSArray *verticalConstraints;
@property (nonatomic, strong) NSLayoutConstraint *equalHeightsConstraint;

// these are really the white view within the red view, original/flawed? concept
@property (nonatomic, strong) NSArray *insideRedHorizontalConstraints;
@property (nonatomic, strong) NSArray *insideRedVerticalConstraints;
@property (nonatomic, strong) NSLayoutConstraint *insideRedEqualHeightsConstraint;

@end

@implementation Z2HSecondEmptyViewController


enum homeButtonDirection
{
    HOME_IS_UNKNOWN,
    HOME_IS_SOUTH,
    HOME_IS_EAST,
    HOME_IS_WEST,
    HOME_IS_NORTH
} homeDirection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"HW-2", @"HW2");
        self.tabBarItem.image = [UIImage imageNamed:@"04-squiggle"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.portraitLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 180, 20)];
    // self.portraitLabel.backgroundColor = [UIColor lightGrayColor];
    self.portraitLabel.backgroundColor = [UIColor colorWithRed:1 green:0.6 blue:0.8 alpha:1];
    self.portraitLabel.textColor = [UIColor brownColor];
    self.portraitLabel.adjustsFontSizeToFitWidth = NO;
    self.portraitLabel.font = [UIFont systemFontOfSize:24];
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation))
    { self.portraitLabel.text = @"Landscape"; }
    else if (deviceOrientation == UIDeviceOrientationPortrait)
    { self.portraitLabel.text = @"Portrait"; }
    else
    { self.portraitLabel.text = @"UpsideDown"; }
    
    self.portraitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // [self.view addSubview:self.portraitLabel];

    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.whiteView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.redView.backgroundColor = [UIColor redColor];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.whiteView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.redView addSubview:self.whiteView];
    [self.redView addSubview:self.portraitLabel];
    [self.view addSubview:self.redView];
    
    self.noactionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.noactionButton setTitle:@"No-action II" forState:UIControlStateNormal];
    self.noactionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.noactionButton addTarget:self
                         action:@selector(noaction:)
                         forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self.noactionButton];
    
    
    [self.view setNeedsUpdateConstraints];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)updateViewConstraints;
{
    [super updateViewConstraints];
    
    NSDictionary *views = @{ @"red" : self.redView,
                             @"white" : self.whiteView,
                             @"portrait" : self.portraitLabel,
                             @"noaction" : self.noactionButton };
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
    { NSLog(@"East edge"); homeDirection = HOME_IS_EAST; }
    else if (deviceOrientation == UIDeviceOrientationLandscapeRight)
    { NSLog(@"West edge"); homeDirection = HOME_IS_WEST; }
    else if (deviceOrientation == UIDeviceOrientationPortrait)
    { NSLog(@"South edge"); homeDirection = HOME_IS_SOUTH; }
    else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    { NSLog(@"North edge"); homeDirection = HOME_IS_NORTH; }
    else
    { NSLog(@"What edge? %d", deviceOrientation);
        homeDirection = HOME_IS_UNKNOWN; }
    
    if (nil != self.insideRedHorizontalConstraints) {
        [self.redView removeConstraints:self.insideRedHorizontalConstraints];
        self. insideRedHorizontalConstraints = nil;
    }
    
    if (self.insideRedHorizontalConstraints == nil) {
        
        NSString *format = nil;
        NSMutableArray *constraints = [NSMutableArray array];
        if (HOME_IS_EAST == homeDirection) {
            format = @"[white(20)]-10-|" ;
            [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:format
                                          options:0 metrics:nil views:views]];
        } else if (HOME_IS_WEST == homeDirection) {
            format = @"|-10-[white(20)]|" ;
            [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:format
                                          options:0 metrics:nil views:views]];
        } else if ((HOME_IS_NORTH == homeDirection) ||
                   (HOME_IS_SOUTH == homeDirection)) {
            [self.redView addConstraint:[NSLayoutConstraint constraintWithItem:self.whiteView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            format = @"20x20 white centered" ;
        }
        
        NSLog(@"Horizontal format: %@", format);
        
        
        if (0 < constraints.count){
            self.insideRedHorizontalConstraints = constraints;
            [self.redView addConstraints:self.insideRedHorizontalConstraints];
        }
    
        [self.redView addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    }
    
    if (nil != self.insideRedVerticalConstraints) {
        [self.redView removeConstraints:self.insideRedVerticalConstraints];
        self.insideRedVerticalConstraints = nil;
    }
    
    if (self.insideRedVerticalConstraints == nil) {
        NSString *format = nil;
        NSMutableArray *constraints = [NSMutableArray array];
        if (HOME_IS_SOUTH == homeDirection) {
            format = @"V:[white(20)]-10-|" ;
            [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:format
                                          options:0 metrics:nil views:views]];
        } else if (HOME_IS_NORTH == homeDirection) {
            format = @"V:|-10-[white(20)]" ;
            [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:format
                                          options:0 metrics:nil views:views]];
        } else if ((HOME_IS_EAST == homeDirection) ||
                   (HOME_IS_WEST == homeDirection)) {
//            [self.redView addConstraint:[NSLayoutConstraint constraintWithItem:self.whiteView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            format = @"V:20x20 white centered" ;
        }
        
        NSLog(@"Vertical format: %@", format);

        if (0 < constraints.count) {
            self.insideRedVerticalConstraints = constraints;
            [self.redView addConstraints:self.insideRedVerticalConstraints];
        }
        
        [self.redView addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }
    
    if (self.horizontalConstraints == nil) {
        NSMutableArray *constraints = [NSMutableArray array];
        
        [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"|-[red]-|"
                                          options:0 metrics:nil views:views]];
        
        [constraints addObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"|-[noaction]-|"
                                          options:0 metrics:nil views:views]];
        
        self.horizontalConstraints = constraints;
        [self.view addConstraints:self.horizontalConstraints];
    }
    
    if (self.verticalConstraints == nil) {
        NSString *format = @"V:|-[red]-[noaction]-|" ;
        self.verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
        [self.view addConstraints:self.verticalConstraints];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orientationChanged:(NSNotification *)notification
{
    // We must add a delay here, otherwise we'll swap in the new view
    // too quickly and we'll get an animation glitch
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation))
    {
        // [self presentModalViewController:self.landscapeViewController animated:YES];
        // isShowingLandscapeView = YES;
        NSLog(@"Landscape");
        self.portraitLabel.text = @"Landscape";
    }
    else if (deviceOrientation == UIDeviceOrientationPortrait)
    {
        // [self dismissModalViewControllerAnimated:YES];
        // isShowingLandscapeView = NO;
        NSLog(@"Portrait");
        self.portraitLabel.text = @"Portrait";
    } else {
        NSLog(@"Upside Down?");
        self.portraitLabel.text = @"UpsideDown";
    }
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
    { NSLog(@"East edge."); }
    else if (deviceOrientation == UIDeviceOrientationLandscapeRight)
    { NSLog(@"West edge."); }
    else if (deviceOrientation == UIDeviceOrientationPortrait)
    { NSLog(@"South edge."); }
    else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    { NSLog(@"North edge."); }
    else
    { NSLog(@"What edge?."); }
    
    [self updateViewConstraints];
}

- (IBAction)noaction:(id)sender;
{
    //  self.blueOnTop = !(self.blueOnTop);
    
//    [self.view removeConstraints:self.verticalConstraints];
//    self.verticalConstraints = nil;
//    [self updateViewConstraints];
//    [UIView animateWithDuration:2.0f animations:^{
//        [self.view layoutIfNeeded];
//    }];
    
    NSLog(@"no action, is there");
}


@end
