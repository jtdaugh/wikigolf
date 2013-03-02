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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Default Courses";
            break;
        case 1:
            return @"User Courses";
            break;
        default:
            break;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows called");
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [[[JTDParseData sharedParseData] defaultCourses] count];
            break;
        case 1:
            return [[[JTDParseData sharedParseData] userCourses] count] + 1;
            break;
        default:
            break;
    }
    return [[[JTDParseData sharedParseData] defaultCourses] count];
}

-(UITableViewCell *) newCourseButtonCell:(UITableViewCell *)cell {
    [cell.textLabel setText:@"+ Create New Course"];
    return cell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    NSMutableArray *tempList, *tempPics;
    NSInteger theRow = 0;
    switch ([indexPath section])
	{
		case 0:
			tempList = [[JTDParseData sharedParseData] defaultCourses];
            tempPics = [[JTDParseData sharedParseData] defaultCoursePics];
            theRow = indexPath.row;
			break;
		case 1:
            if ([indexPath row] == 0) {
                return [self newCourseButtonCell:cell];
                
            } else {
                tempList = [[JTDParseData sharedParseData] userCourses];
                tempPics = [[JTDParseData sharedParseData] userCoursePics];
                theRow = indexPath.row - 1;
            }
			break;
	}
    
    
    
    PFObject *object = [tempList objectAtIndex:theRow];
    NSLog(@"Loaded row %d", theRow);
    if ([tempPics objectAtIndex:theRow] != NULL) {
        [cell.imageView setImage:[UIImage imageWithData: [tempPics objectAtIndex:theRow]]];
    }
    [cell.textLabel setText:[object objectForKey:@"name"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JTDWikiViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"courseChosen"];
    JTDCreateCourseViewController *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"choose2create"];
    switch ([indexPath section]) {
        case 0:
            [controller setCourse:[[[JTDParseData sharedParseData] defaultCourses] objectAtIndex:indexPath.row]];
            break;
        case 1:
            if ([indexPath row] == 0) {
                [self.navigationController pushViewController:controller2 animated:YES];
            } else {
                [controller setCourse:[[[JTDParseData sharedParseData] userCourses] objectAtIndex:indexPath.row - 1]];
            }
            break;
        default:
            break;
    }
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    
    [self.navigationController pushViewController:controller animated:YES];
}



@end
