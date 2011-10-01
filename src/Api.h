#import <Foundation/Foundation.h>

NewTypeInterface(AccessToken, NSString, value);
NewType2Interface(AuthenticationResponse, NSString, value, NSString, humanMessage)

@interface AuthenticationResponse (more)
- (BOOL)isOk;
@end

@interface Api : NSObject

+ (AuthenticationResponse *)authenticate:(AccessToken *)token;
+ (NSArray *)retrieveQueue;

+ (dispatch_queue_t)apiQueue;
@end
