//
//  ToDoItem.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/30/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem
@synthesize description;
@synthesize completed;
@synthesize completedDate;
@synthesize startDate;
@synthesize name;

-(id) init
{
    self = [super init];
    if(self)
    {
        name = @"ToDo";
        startDate = [[NSDate alloc] init];
        completed = false;
        completedDate = Nil;
        description = @"This is a ToDo item.";
    }
    return self;
}

-(id)init: (ToDoItem*) copy
{
    self = [super init];
    
    if(self)
    {
        name = [[NSString alloc] initWithString:[copy name]];
        description = [[NSString alloc] initWithString:[copy description]];
        completed = [copy completed];
        startDate = [copy startDate];
        completedDate = [copy completedDate];
    }
    return self;
}
-(id)init: (NSString*) namet : (NSDate*)rightNow : (bool) complete : (NSString*)descrip : (NSDate*)enddate
{
    self = [super init];
    
    if(self)
    {
        name = [[NSString alloc] initWithString:namet];
        description = [[NSString alloc] initWithString:descrip];
        completed = complete;
        startDate = rightNow;
        completedDate = enddate;
    }
    return self;
}

-(id) copyWithZone: (NSZone *) zone
{
    ToDoItem *copy = [[ToDoItem allocWithZone: zone] init];
   
    [copy setName:[[NSString alloc] initWithString:[self name]]];
    [copy setDescription:[[NSString alloc] initWithString:[self description]]];
    [copy setCompleted:[self completed]];
    [copy setStartDate:[self startDate]];
    [copy setCompletedDate:[self completedDate]];
    
    return copy;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    // This initializes the object when loaded from file
    if(self)
    {
        name = [[NSString alloc] initWithString:[aDecoder decodeObjectForKey:@"nameKey"]];
    
        [self setStartDate:[aDecoder decodeObjectForKey:@"startDateKey"]];
        
        [self setCompleted:[aDecoder decodeBoolForKey:@"completedKey"]];
        
        description = [[NSString alloc] initWithString:[aDecoder decodeObjectForKey:@"descriptionKey"]];

        [self setCompletedDate:[aDecoder decodeObjectForKey:@"completedDateKey"]];
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"nameKey"];
    [aCoder encodeObject:startDate forKey:@"startDateKey"];
    [aCoder encodeBool:completed forKey:@"completedKey"];
    [aCoder encodeObject:completedDate forKey:@"completedDateKey"];
    [aCoder encodeObject:description forKey:@"descriptionKey"];
}
@end
