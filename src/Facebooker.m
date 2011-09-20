#import "Facebooker.h"

NewTypeImplementation(AccessToken, NSString, value);

@implementation Facebooker

- (void)dealloc {
    [facebook release];
    [super dealloc];
}

- (id)initWithFacebook:(Facebook *)fb {
    if ((self = [super init])) {
        facebook = [fb retain];
        facebook.sessionDelegate = self;
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
