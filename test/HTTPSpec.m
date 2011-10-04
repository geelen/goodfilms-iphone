#import "HTTPSpec.h"
#import "Api.h"

@implementation HTTPSpec

- (void)testAppDelegate {    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}

- (void)testLoginFailWithoutMessage {
    FKEither *r1 = [Api checkForErrors:NSDICT(@"foo", @"error")];
    NSError *f = r1.left.value;
    STAssertEqualObjects(f.localizedDescription, @"Couldn't login to Goodfilms.", nil);
}

- (void)testLoginFailWithMessage {
    FKEither *r1 = [Api checkForErrors:NSDICT(@"foo", @"error", @"message", @"message")];
    NSError *f = r1.left.value;
    STAssertEqualObjects(f.localizedDescription, @"message", nil);
}

@end
