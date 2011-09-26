#import <Foundation/Foundation.h>
#import "User.h"

NewTypeInterface(AccessToken, NSString, value);
NewTypeInterface(AuthenticationResponse, NSString, value)

@interface Api : NSObject {
    NSString *base;
}

- (id)initWithBase:(NSString *)b;

- (AuthenticationResponse *)authenticate:(AccessToken *)token;
- (NSArray *)retrieveQueue;

+ (Api *)localhost;
@end
