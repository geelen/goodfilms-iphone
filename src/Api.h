#import <Foundation/Foundation.h>

NewTypeInterface(AccessToken, NSString, value);

@interface Api : NSObject

+ (FKEither *)authenticate:(AccessToken *)token;
+ (FKEither *)retrieveQueue;

+ (FKEither *)retrieveFilm:(NSNumber *)ident;

+ (dispatch_queue_t)apiQueue;

// For testing
+ (FKEither *)checkForErrors:(NSDictionary *)dictionary;
@end
