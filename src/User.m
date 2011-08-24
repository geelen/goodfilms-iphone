//
//  Queue.m
//  goodfilms
//
//  Created by Glen Maddern on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "User.h"

@implementation User

@synthesize queue, wat;

- (void)dealloc {
    [queue release];
    [wat release];
    [super dealloc];
}

- (id)initWithId:(NSString *)i
{
    self = [super init];
    if (self) {
        wat = [i retain];
        // Initialization code here.
    }
    
    return self;
}

@end
