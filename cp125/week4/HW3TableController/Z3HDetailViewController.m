//
//  Z3HDetailViewController.m
//  HW3TableController
//
//  Created by Don Zeek on 2/10/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import "Z3HDetailViewController.h"

@interface Z3HDetailViewController ()

@end

static NSString *StatesTableIdentifier = @"StatesTableIdentifier";

@implementation Z3HDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Detail";
    }
    // will not work if you don't return self
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // this need protection
    self.title = [self.the_facts valueForKey:@"name"];

    // UITableView *tableView = (id)[self.view viewWithTag:1];

    if (nil == self.keys) {
        self.keys = @[@"Cities",@"History",@"Geography"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger     ret = 0;
    
    if (1 == tableView.tag) {
        ret = [self.keys count];
    }
    
    // NSLog(@"numberOfSectionsInTableView: # sections in table: %d", ret);
    
    return ret;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    if (1 == tableView.tag) {
        
        NSString *key = self.keys[section];
        NSLog(@"numberOfRowsInSection: in keys at %d, key: %@", section, key);
        
        switch (section) {
            case 0:
                ret = 2;  // for Cities, return Capital and Populous
                break;
                
            case 1:
                ret = 1;  // for History, return only Date
                break;
                
            case 2:
                ret = 2;  // for Geography, return only Population and Size
                break;
                
            default:
                break;
        }
    }
    
    NSLog(@"numberOfRowsInSection: for section %d, number of rows: %d", section, ret);
    
    return ret;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatesTableIdentifier ];
    if (nil == cell) {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatesTableIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:StatesTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:StatesTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:StatesTableIdentifier];
    }

    if (1 == tableView.tag) {
        
        NSString *key = self.keys[indexPath.section];
        NSLog(@"cellForRowAtIndexPath: key for section(%d) is: %@", indexPath.section, key);
        
        // NSArray *nameSection = self.states[key];
        // NSLog(@"cellForRowAtIndexPath: dictionary entries for section: %@", nameSection);
 
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = [self.the_facts valueForKey:@"capital"];
                    }
                        break;
                    case 1:
                    {
                        cell.textLabel.text = [self.the_facts valueForKey:@"populousCity"];
                    }
                        break;
                    default:
                        break;
                }
                break;
            case 1:
                switch (indexPath.row) {
                    case 0:
                    {
                        // cell.textLabel.text = [self.the_facts valueForKey:@"date"];
                        // NSObject *inauguration_day = [self.the_facts valueForKey:@"date"];
                        // NSLog(@"Class of date: %@", [inauguration_day class]);
                        NSDate *began_statehood = [self.the_facts valueForKey:@"date"];
                        // NSLog(@"Date: %@",[began_statehood description] );
                        cell.textLabel.text = [began_statehood description];
                    }
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                switch (indexPath.row) {
                    case 0:
                    {
                        // cell.textLabel.text = [self.the_facts valueForKey:@"population"];
                        NSObject *nPeople = [self.the_facts valueForKey:@"population"];
                        NSLog(@"Class of population: %@", [nPeople class]);
                        // NSNumber *n_people
                    }
                        break;
                    case 1:
                    {
                        // cell.textLabel.text = [self.the_facts valueForKey:@"area"];
                        NSObject *nLandSize = [self.the_facts valueForKey:@"area"];
                        NSLog(@"Class of area: %@", [nLandSize class]);
                    }
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }

        // cell.textLabel.text = [self.the_facts valueForKey:@"name"];
        // cell.detailTextLabel.text = [self.the_facts valueForKey:@"capital"];

        cell.imageView.image = [UIImage imageNamed:@"connecticut-50.png"];
    }
    return cell;
}



@end
