//
//  ToDoList.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/6/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@interface ToDoList : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *category;

@property(strong, nonatomic) NSMutableArray *list;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id) copyWithZone: (NSZone *) zone;
-(id)init : (NSString*)namet : (NSMutableArray*)listt :(NSString*) categoryt;
-(id)init : (ToDoList*) copy;

@end
