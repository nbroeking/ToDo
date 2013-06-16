//
//  ToDoItem.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/30/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *startDate;
@property  bool completed;
@property (strong, nonatomic) NSDate *completedDate;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *parentName;

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;
-(id) copyWithZone: (NSZone *) zone;
-(id)init: (NSString*) namet : (NSDate*)rightNow : (bool) complete : (NSString*)descrip : (NSDate*)enddate :(NSString*) parentNamet;
-(id)init: (ToDoItem*) copy;

@end
