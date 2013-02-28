//
//  JTDChooseCourseViewController.h
//  wikigolf3_fuckchris
//
//  Created by Jesse Daugherty on 2/27/13.
//  Copyright (c) 2013 Jesse Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JTDParseData.h"
#import "JTDWikiViewController.h"

@interface JTDChooseCourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
