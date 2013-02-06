//
//  DZViewController.m
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/19/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "DZViewController.h"

#import "DZCoverViewController.h"
#import "DZFlipViewController.h"
#import "DZCrossViewController.h"
#import "DZPartialCurlViewController.h"

@interface DZViewController ()

@end

@implementation DZViewController {
    int n_coverVertical;
    int n_flipHorizontal;
    int n_crossDissolve;
    int n_partialCurl;
    
    enum homeButtonDirection
    {
        HOME_IS_SOUTH,
        HOME_IS_EAST,
        HOME_IS_WEST,
        HOME_IS_NORTH
    } HomeDirection;
    
}

// pulled from z2hFirstViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"HW-1", @"HW-1");
        self.tabBarItem.image = [UIImage imageNamed:@"03-loopback"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    n_coverVertical = 0;
    n_flipHorizontal = 0;
    n_crossDissolve = 0;
    n_partialCurl = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"init-did-receive-memory-warning");   
    void(^logDismissedComplete)(void) = ^ {
        NSLog(@"init-dismissed-complete");
        return;
    };
    
    [self dismissViewControllerAnimated:YES completion:logDismissedComplete];
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"init-view-will-disappear");
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"init-view-did-disappear");
    return;
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        
        // NSString *msg=nil;
        // msg = [NSString stringWithFormat:@"Button %d pressed", buttonIndex];
        // NSLog(msg);
        
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"Destroy");
                [self showTerminator:nil];
            }
                break;
            case 1:
            {
                NSLog(@"Cover Vertical button index");
                n_coverVertical++;
                NSString *caption1 = [[NSString alloc] initWithFormat:@"CoverVertical: called %d times", n_coverVertical];
                [self.coverVertical setText:caption1];
            
                void(^logCoverComplete)(void) = ^ {
                    NSLog(@"Cover Vertical View Controller up");
                    return;
                };
                DZCoverViewController *dzCoverViewController = [[DZCoverViewController alloc] initWithNibName:@"DZCoverViewController" bundle:nil];
                [self presentViewController:dzCoverViewController animated:YES completion:logCoverComplete];
            }
                break;
            case 2:
            {
                NSLog(@"Flip Horizontal button index");
                n_flipHorizontal++;
                NSString *caption1 = [[NSString alloc] initWithFormat:@"FlipHorizontal: called %d times", n_flipHorizontal];
                [self.flipHorizontal setText:caption1];
            
                void(^logFlipComplete)(void) = ^ {
                    NSLog(@"Flip Horizontal View Controller up");
                    return;
                };
                DZFlipViewController *dzFlipViewController = [[DZFlipViewController alloc] initWithNibName:@"DZFlipViewController" bundle:nil];
                [self presentViewController:dzFlipViewController animated:YES completion:logFlipComplete];
            }
                break;
            case 3:
            {
                NSLog(@"Cross Dissolve button index");
                n_crossDissolve++;
                NSString *caption1 = [[NSString alloc] initWithFormat:@"CrossDissolve: called %d times", n_crossDissolve];
                [self.crossDissolve setText:caption1];
            
                void(^logCrossComplete)(void) = ^ {
                    NSLog(@"Cross Dissolve View Controller up");
                    return;
                };
                DZCrossViewController *dzCrossViewController = [[DZCrossViewController alloc] initWithNibName:@"DZCrossViewController" bundle:nil];
                [self presentViewController:dzCrossViewController animated:YES completion:logCrossComplete];
            }
                break;
            case 4:
            {
                NSLog(@"Partial Curl button index");
                n_partialCurl++;
                NSString *caption1 = [[NSString alloc] initWithFormat:@"PartialCurl: called %d times", n_partialCurl];
                [self.partialCurl setText:caption1];
            
                void(^logPartialComplete)(void) = ^ {
                    NSLog(@"Partial Curl View Controller up");
                    return;
                };
                DZPartialCurlViewController *dzPartialViewController = [[DZPartialCurlViewController alloc] initWithNibName:@"DZPartialCurlViewController" bundle:nil];
                [self presentViewController:dzPartialViewController animated:YES completion:logPartialComplete];
            }
                break;
            default:
                break;
        }
    } else {
        NSLog(@"Cancel button, just return");
    }
    
}

- (IBAction)showMore:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Modal Transition"
                                  delegate:self cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Destroy"
                                  otherButtonTitles:@"Cover Vertical",
                                                    @"Flip Horizontal",
                                                    @"Cross Dissolve",
                                                    @"Partial Curl", nil];
    // [actionSheet showInView:self.view];
    // [actionSheet showFromTabBar:self.view];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void) alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        NSLog(@"Cancel Alert");
        self.view.backgroundColor = [UIColor lightGrayColor];
    }else {
        NSLog(@"Show Red all over");
        if ([self isViewLoaded]) {
            NSLog(@"View is loaded");
            self.view.backgroundColor = [UIColor redColor];
        } else {
            NSLog(@"View is not loaded");
        }
    }
}

- (IBAction)showTerminator:(id)sender {
    // initialize first
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Really Destroy?" message:@"This will destroy everything" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [alertView show];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
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
        NSLog(@"orientationChanged: Landscape");
        
        _coverVertical.frame = CGRectMake(84, 125, 131, 21);
        _flipHorizontal.frame = CGRectMake(84, 154, 133, 21);
        _crossDissolve.frame = CGRectMake(258, 125, 137, 21);
        _partialCurl.frame = CGRectMake(258, 154, 108, 21);
        
    }
    else if (deviceOrientation == UIDeviceOrientationPortrait)
    {
        // [self dismissModalViewControllerAnimated:YES];
        // isShowingLandscapeView = NO;
        NSLog(@"orientationChanged: Portrait");
        
        _coverVertical.frame = CGRectMake(95, 95, 131, 21);
        _flipHorizontal.frame = CGRectMake(94, 124, 133, 21);
        _crossDissolve.frame = CGRectMake(92, 153, 137, 21);
        _partialCurl.frame = CGRectMake(106, 182, 108, 21);
        
    } else {
        NSLog(@"orientationChanged: Upside Down?");
        
        _coverVertical.frame = CGRectMake(95, 95, 131, 21);
        _flipHorizontal.frame = CGRectMake(94, 124, 133, 21);
        _crossDissolve.frame = CGRectMake(92, 153, 137, 21);
        _partialCurl.frame = CGRectMake(106, 182, 108, 21);
        
    }
    [self.view setNeedsUpdateConstraints];
}



@end
