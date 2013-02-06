//
//  DZViewController.h
//  HW1ViewControllerIntro
//
//  Created by Don Zeek on 1/19/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZViewController : UIViewController <UIActionSheetDelegate>
//- (IBAction)showmore:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *coverVertical;
@property (weak, nonatomic) IBOutlet UILabel *flipHorizontal;
@property (weak, nonatomic) IBOutlet UILabel *crossDissolve;
@property (weak, nonatomic) IBOutlet UILabel *partialCurl;

- (IBAction)showMore:(UIButton *)sender;

@end
