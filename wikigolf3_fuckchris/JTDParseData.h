//
//  JTDParseData.h
//  wikigolf3_fuckchris
//
//  Created by Jesse Daugherty on 2/28/13.
//  Copyright (c) 2013 Jesse Daugherty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface JTDParseData : NSObject {
    
    NSMutableArray *defaultCourses;
    NSMutableArray *userCourses;
    NSMutableArray *holes;
    NSMutableArray *defaultCoursePics;
    NSMutableArray *userCoursePics;
    NSMutableArray *holePics;
}

@property (nonatomic, retain) NSMutableArray *defaultCourses;
@property (nonatomic, retain) NSMutableArray *userCourses;
@property (nonatomic, retain) NSMutableArray *holes;
@property (nonatomic, retain) NSMutableArray *defaultCoursePics;
@property (nonatomic, retain) NSMutableArray *userCoursePics;
@property (nonatomic, retain) NSMutableArray *holePics;

+ (id)sharedParseData;

-(void) getDefaultCoursesFromParse;
-(void) getUserCoursesFromParse;
-(void) pullHolesFromParseforCourse: (PFObject *) course;


@end
