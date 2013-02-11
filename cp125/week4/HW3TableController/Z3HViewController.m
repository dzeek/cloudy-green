//
//  Z3HViewController.m
//  HW3TableController
//
//  Created by Don Zeek on 2/7/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import "Z3HViewController.h"
#import "Z3HDetailViewController.h"

@interface Z3HViewController ()

@end

static NSString *StatesTableIdentifier = @"StatesTableIdentifier";

@implementation Z3HViewController {
    NSMutableArray *filteredNames;
    UISearchDisplayController *searchController;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"did select: %@", indexPath);
    Z3HDetailViewController *vc = [[Z3HDetailViewController alloc] initWithNibName:@"Z3HDetailViewController" bundle:nil];
    vc.title = @"oregon";
    
    // get the dictionary for this index
    
    if (1 == tableView.tag) {
        
        NSString *key = self.keys[indexPath.section];
        NSArray *keyletterSection = self.states[key];
        vc.the_facts = keyletterSection[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        return nil;
    }
    
    // self.title = @"No Load";
    self.title = @"States";
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = (id)[self.view viewWithTag:1];

    // the following sets style to Default, or autocreates on nil pointers, messes up
    // [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:StatesTableIdentifier];
    
    
    // page 334 (37%)
    filteredNames = [NSMutableArray array];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    tableView.tableHeaderView = searchBar;
    searchController= [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    // NSLog(@"viewDidLoad: path to the states.plist: %@", path);
    
    NSMutableArray *arraystates = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"Array-of-states count: %d", [arraystates count]);
    
    if (nil == self.keys) {
        self.keys = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                    @"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",
                    @"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",
                    @"X",@"Y",@"Z"];
        // NSLog(@"viewDidLoad: array keys count: %d", [self.keys count]);
 
        //  The next snippet creates an alphabet-keyed array of MutableArrays.  While the
        //  basis arrays are still zero length, a dictionary is created with that array.
        //  Mutable arrays are then drawn out, updated, and put back, replacing the original
        //  date, in the following snippet
        int jzmax = [self.keys count];
        NSMutableArray *arrayOfZeroLengArrays = [[NSMutableArray alloc] initWithCapacity:jzmax];
        for (int jz=0; jz<jzmax; jz++){
            [arrayOfZeroLengArrays addObject:[[NSMutableArray alloc] init] ];
        }
        self.states = [[NSMutableDictionary alloc] initWithObjects:arrayOfZeroLengArrays forKeys:self.keys];
        
        //  This following snippet goes through the 26 keys, for each key:
        //       retrieving its entry from the index into the states dictionary,
        //       going through the dictionary to get names starting with its index letter
        //            adding just the name to the array checked out,
        //             implying a string array
        //       MODIFIED TO . adding the entire Dictionary entry for that state
        int jz2=0;
        for (NSString *stateKey in self.keys) {
            NSMutableArray *newItem = [arrayOfZeroLengArrays objectAtIndex:jz2];
            for (NSDictionary *muscleDict in arraystates) {
                NSString *statename = [muscleDict valueForKey:@"name"];
                if ([statename hasPrefix:stateKey]) {
                    // NSLog(@"viewDidLoad: state entry added to letter array: %@", statename);
                    [newItem addObject:muscleDict];
                }
            }
            // NSLog(@"viewDidLoad: new-item, list of state-info-dictnry for letter, count: %d", [newItem count]);
            
            [arrayOfZeroLengArrays replaceObjectAtIndex:jz2 withObject:newItem];
            jz2++;
        }
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
    NSInteger     ret;
    
    if (1 == tableView.tag) {
        ret = [self.keys count];
    } else {
        ret = 1;
    }
    
    NSLog(@"Number of sections in table: %d", ret);
    
    return ret;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret;
    if (1 == tableView.tag) {
        NSString *key = self.keys[section];
        
        // NSLog(@"in keys at %d, key: %@", section, key);
        
        NSArray *nameSection = self.states[key];
        ret = [nameSection count];
    } else {
        ret = [filteredNames count];
    }
    
    // NSLog(@"numberOfRowsInSection: for section %d, number of rows: %d", section, ret);
    
    return ret;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (1 == tableView.tag) {
        return self.keys[section];
    } else {
        return nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatesTableIdentifier ];
    if (nil == cell) {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatesTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:StateStatesIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:StatesTableIdentifier];
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:StatesTableIdentifier];
    }

    if (1 == tableView.tag) {
        
        NSString *key = self.keys[indexPath.section];
        // NSLog(@"cellForRowAtIndexPath: key for section(%d) is: %@", indexPath.section, key);
        
        NSArray *nameSection = self.states[key];
        // NSLog(@"cellForRowAtIndexPath: dictionary entries for section: %@", nameSection);
        
	// MODIFICATION CONTINUES HERE
        // what is available on the nameSection array is now the full
        // dictionary for the state.
        NSDictionary *stateInfo = nameSection[indexPath.row];

        cell.textLabel.text = [stateInfo valueForKey:@"name"];
        cell.detailTextLabel.text = [stateInfo valueForKey:@"capital"];

        
        NSString *state_lower_case = [[NSString alloc] initWithString:cell.textLabel.text];
        state_lower_case = [state_lower_case lowercaseString];
        NSString *image_name = [state_lower_case stringByAppendingString:@"-50.png"];
        
        // change blanks to underbars here
        image_name = [image_name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        // NSLog(@"cellForRowAtIndexPath: image name: %@", image_name);
        // cell.imageView.image = [UIImage imageNamed:@"connecticut-50.png"];
        cell.imageView.image = [UIImage imageNamed:image_name];
    } else {
        cell.textLabel.text = filteredNames[indexPath.row];
    }
    return cell;
}

// implements index along right side
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (1 == tableView.tag) {
        return self.keys;
    } else {
        return nil;
    }
}

#pragma mark -
#pragma Search Display Delegate Methods

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:StatesTableIdentifier];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [filteredNames removeAllObjects];
    if (0 < searchString.length) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *b) {
            NSRange range = [name rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        for (NSString *key in self.keys) {
            NSArray *matches = [self.states[key] filteredArrayUsingPredicate:predicate];
            [filteredNames addObjectsFromArray:matches];
        }
    }
    return YES;
}

@end
