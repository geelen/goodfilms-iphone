#import "HTTPSpec.h"

@implementation HTTPSpec

- (void)testAppDelegate {    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}

- (void)testMath {
    STAssertTrue((1+3)==2, @"Compiler isn't feeling well today :-(" );
    
}

@end
