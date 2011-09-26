//
//  HTTPSpec.m
//  goodfilms
//
//  Created by Nick Partridge on 26/09/11.
//  Copyright 2011 Mogeneration. All rights reserved.
//

#import "HTTPSpec.h"

@implementation HTTPSpec

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void)testAppDelegate {    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void)testMath {
    
    STAssertTrue((1+3)==2, @"Compiler isn't feeling well today :-(" );
    
}

#endif

@end
