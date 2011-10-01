#import "Api.h"
#import "Film.h"
#import "JSON.h"
#import "HTTP.h"

NewTypeImplementation(AccessToken, NSString, value)
NewType2Implementation(AuthenticationResponse, NSString, value, NSString, humanMessage)

@implementation AuthenticationResponse (more)
- (BOOL)isOk {
    return [self.value isEqual:@"ok"];
}

@end
@interface Api (privates)
+ (NSString *)slash:(NSString *)bit;
@end

@implementation Api

+ (NSArray *)retrieveQueue {
    FKEither *responseData = [HTTP get:[self slash:@"/api/queue"] parameters:NSDICT(@"lolbfuscation", @"api_key")];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseJson:)];
    if ([jsonResponse isRight]) {
        NSArray *rawFilmsJson = jsonResponse.right.value;
        return [rawFilmsJson mapOption:functionP(NSDictionaryToFilm)];
    } else {
        return [NSArray array];
    }
}

+ (AuthenticationResponse *)authenticate:(AccessToken *)token {
    FKEither *responseData = [HTTP get:[self slash:@"/api/login"] parameters:EMPTY_DICT];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseJson:)];
    if (jsonResponse.isRight) {
        __unused NSDictionary *d = jsonResponse.right.value;
        return [AuthenticationResponse value:@"fail" humanMessage:@"TODO"];
    } else {
        NSError *e = responseData.left.value;
        return [AuthenticationResponse value:@"fail" humanMessage:e.localizedDescription];
    }
}

+ (dispatch_queue_t)apiQueue {
    return dispatch_get_global_queue(0, 0);
}

+ (FKEither *)parseJson:(NSData *)input {
    NSString *s = [NSString stringWithData:input];
    return [[JSON parse:s] toEitherWithError:@"Unexpected response from goodfilms."];
}

#pragma mark privates

+ (NSString *)slash:(NSString *)bit {
    return [@"http://goodfil.ms" stringByAppendingPathComponent:bit];
}

@end
