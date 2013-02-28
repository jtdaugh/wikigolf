//
//  JTDChooseCourseViewController.m
//  wikigolf3_fuckchris
//
//  Created by Jesse Daugherty on 2/27/13.
//  Copyright (c) 2013 Jesse Daugherty. All rights reserved.
//

#import "JTDChooseCourseViewController.h"

@interface JTDChooseCourseViewController ()

@end

@implementation JTDChooseCourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows called");
    // Return the number of rows in the section.
    return [[[JTDParseData sharedParseData] defaultCourses] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    PFObject *object = [[[JTDParseData sharedParseData] defaultCourses] objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageWithData: [[[JTDParseData sharedParseData] defaultCoursePics] objectAtIndex:indexPath.row]]];
    [cell.textLabel setText:[object objectForKey:@"name"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JTDWikiViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoVC"];
    [controller setCourse:[[JTDParseData sharedParseData] objectAtIndex:indexPath.row]];
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    
    [self.navigationController pushViewController:controller animated:YES];
}



@end
