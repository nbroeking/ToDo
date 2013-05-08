//
//  ToDoList.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/6/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "ToDoList.h"

@implementation ToDoList
@synthesize name;
@synthesize list;

- (id)init
{
    self = [super init];
    if (self)
    {
        name = @"All";
        list = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id)init : (ToDoList*) copy
{
    self = [super init];
    
    if(self)
    {
        name = [[NSString alloc] initWithString:[copy name]];
        list = [[NSMutableArray alloc] initWithArray: [copy list]];
    }
    
    return self;
    
}
-(id)init : (NSString*)namet : (NSMutableArray*)listt
{
    self = [super init];
    if (self)
    {
        name = [[NSString alloc] initWithString:namet];
        list = [[NSMutableArray alloc] initWithArray:listt];
    }
    return self;
}

-(id) copyWithZone: (NSZone *) zone
{
    ToDoList *copy = [[ToDoList allocWithZone: zone] init];
    
    [copy setName:[[NSString alloc] initWithString:[self name]]];
    [copy setList: [[NSMutableArray alloc] initWithArray:[self list]]];
    
    return copy;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    // This initializes the object when loaded from file
    if(self)
    {
        name = [[NSString alloc]initWithString:[aDecoder decodeObjectForKey:@"nameKey"]];
        list = [[NSMutableArray alloc] initWithArray:[aDecoder decodeObjectForKey:@"listKey"]];
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"nameKey"];
    [aCoder encodeObject:list forKey:@"listKey"];
}
@end
