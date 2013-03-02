//
//  JTDParseData.m
//  wikigolf3_fuckchris
//
//  Created by Jesse Daugherty on 2/28/13.
//  Copyright (c) 2013 Jesse Daugherty. All rights reserved.
//

#import "JTDParseData.h"

@implementation JTDParseData

@synthesize defaultCourses, userCourses, holes, defaultCoursePics, userCoursePics, holePics;

+(id) sharedParseData {
    static JTDParseData *sharedJTDParseData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        sharedJTDParseData = [[self alloc] init];
    });
    return sharedJTDParseData;
}

-(id) init {
    if (self = [super init]) {
        defaultCourses = [[NSMutableArray alloc] init];
        userCourses = [[NSMutableArray alloc] init];
        holes = [[NSMutableArray alloc] initWithCapacity:9];
        holePics = [[NSMutableArray alloc] initWithCapacity:9];
        
        [self getDefaultCoursesFromParse];
        [self getUserCoursesFromParse];
    }
    return self;
}

-(void) getDefaultCoursesFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    [query addDescendingOrder:@"popularity"];
    [query whereKey:@"default" equalTo:[NSNumber numberWithBool:YES]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d default courses.", objects.count);
            [defaultCourses removeAllObjects];
            [defaultCourses addObjectsFromArray:objects];
            defaultCoursePics = [NSMutableArray arrayWithCapacity:[defaultCourses count]];
            for(int i = 0; i < [defaultCourses count]; i++) [defaultCoursePics addObject: [NSNull null]];
            
            for (int i = 0; i < [defaultCourses count]; i++) {
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[defaultCourses objectAtIndex:i] objectForKey:@"iconUrl"]]];
                    if ( data == nil )
                        return;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        [defaultCoursePics replaceObjectAtIndex:i withObject:data];
                        NSLog(@"added pic");
                    });
                });
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


-(void) getUserCoursesFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    [query whereKey:@"default" equalTo:[NSNumber numberWithBool:NO]];
    [query addDescendingOrder:@"createdAt"];
    [query setLimit:20];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d user courses.", objects.count);
            [userCourses removeAllObjects];
            [userCourses addObjectsFromArray:objects];
            userCoursePics = [NSMutableArray arrayWithCapacity:[userCourses count]];
            for(int i = 0; i <
                [userCourses count]; i++) [userCoursePics addObject: [NSNull null]];

            for (int i = 0; i < [userCourses count]; i++) {
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[userCourses objectAtIndex:i] objectForKey:@"iconUrl"]]];
                    if ( data == nil )
                        return;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        [userCoursePics replaceObjectAtIndex:i withObject:data];
                    });
                });
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void) pullHolesFromParseforCourse: (PFObject *) course {
    PFQuery *query = [PFQuery queryWithClassName:@"Hole"];
    [query whereKey:@"course" equalTo:course];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d default courses.", objects.count);
            [holes removeAllObjects];
            [holes addObjectsFromArray:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end


