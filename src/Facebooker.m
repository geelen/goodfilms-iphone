#import "Facebooker.h"

NewTypeImplementation(AccessToken, NSString, value);

@implementation Facebooker

- (void)dealloc {
    [facebook release];
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {
        facebook = [[Facebook alloc] initWithAppId:@"172347429470735" andDelegate:self];
    }
    return self;
}

- (void)signIn {
    [facebook authorize:EMPTY_ARRAY];
}

#pragma FBSessionDelegate
- (void)fbDidLogin {
    NSString *accessToken = facebook.accessToken;
    successCallback([AccessToken value:accessToken]);
}

@end
