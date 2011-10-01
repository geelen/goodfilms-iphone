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
    NSData *responseData = [HTTP get:[self slash:@"/api/queue"] parameters:NSDICT(@"lolbfuscation", @"api_key")];
    if (responseData) {
        NSString *s = [NSString stringWithData:responseData];
        NSArray *parsedObject = [JSON parse:s];
        return [parsedObject mapOption:functionP(NSDictionaryToFilm)];
    } else {
        return [NSArray array];
    }
}

+ (AuthenticationResponse *)authenticate:(AccessToken *)token {
    __unused NSData *responseData = [HTTP get:[self slash:@"/api/login"] parameters:EMPTY_DICT];
    return [AuthenticationResponse value:@"fail" humanMessage:@"Not implemented yet."];
}


+ (dispatch_queue_t)apiQueue {
    return dispatch_get_global_queue(0, 0);
}

#pragma mark privates

+ (NSString *)slash:(NSString *)bit {
    return [@"http://goodfil.ms" stringByAppendingPathComponent:bit];
}

@end
