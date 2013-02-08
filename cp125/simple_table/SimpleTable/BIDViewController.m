//
//  BIDViewController.m
//  SimpleTable
//
//  Created by Don Zeek on 1/6/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

@end

@implementation BIDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dwarves = @[@"Sleepy", @"Sneezy", @"Bashful", @"Happy", @"Doc", @"Grummpy", @"Dopey",
    @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili",
    @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur" ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dwarves count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];
        
        
    }
    
    UIImage *image = [UIImage imageNamed:@"star.png"];
    cell.imageView.image = image;
    
    UIImage *hilite_image = [UIImage imageNamed:@"star2.png"];
    cell.imageView.highlightedImage = hilite_image;
    
    cell.textLabel.text = self.dwarves[indexPath.row];
    
    if (indexPath.row < 7) {
        cell.detailTextLabel.text = @"Mr. Disney";
    } else {
        cell.detailTextLabel.text = @"Mr. Tokien";
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        return nil;
    } else {
        return indexPath;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = self.dwarves[indexPath.row];
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue ];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected!"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"Yes, I did"
                                           otherButtonTitles:nil ];
                          
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
