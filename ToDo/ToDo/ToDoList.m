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
@synthesize category;

- (id)init
{
    self = [super init];
    if (self)
    {
        name = @"All";
        category = @"Misc.";
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
        category = [[NSString alloc] initWithString:[copy category]];
    }
    
    return self;
    
}
-(id)init : (NSString*)namet : (NSMutableArray*)listt :(NSString*) categoryt
{
    self = [super init];
    if (self)
    {
        name = [[NSString alloc] initWithString:namet];
        list = [[NSMutableArray alloc] initWithArray:listt];
        category = [[NSString alloc] initWithString:categoryt];
    }
    return self;
}

-(id) copyWithZone: (NSZone *) zone
{
    ToDoList *copy = [[ToDoList allocWithZone: zone] init];
    
    [copy setName:[[NSString alloc] initWithString:[self name]]];
    [copy setList: [[NSMutableArray alloc] initWithArray:[self list]]];
    [copy setCategory:[[NSString alloc] initWithString:[self category]]];
    
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
        category = [[NSString alloc] initWithString:[aDecoder decodeObjectForKey:@"catKey"]];
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"nameKey"];
    [aCoder encodeObject:list forKey:@"listKey"];
    [aCoder encodeObject:category forKey:@"catKey"];
}
@end
