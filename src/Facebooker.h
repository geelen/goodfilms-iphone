#import <Foundation/Foundation.h>
#import "FBConnect.h"

NewTypeInterface(AccessToken, NSString, value);

typedef void(^FacebookSuccess)(AccessToken *);

@interface Facebooker : NSObject <FBSessionDelegate> {
    Facebook *facebook;
    FacebookSuccess successCallback;
}

- (void)signIn;

@end
