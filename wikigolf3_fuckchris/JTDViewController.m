//
//  JTDViewController.m
//  wikigolf3_fuckchris
//
//  Created by Jesse Daugherty on 2/27/13.
//  Copyright (c) 2013 Jesse Daugherty. All rights reserved.
//

#import "JTDViewController.h"

@interface JTDViewController ()

@end

@implementation JTDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
