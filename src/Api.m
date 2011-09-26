#import "Api.h"
#import "Film.h"
#import "JSON.h"
#import "HTTP.h"

NewTypeImplementation(AccessToken, NSString, value)
NewTypeImplementation(AuthenticationResponse, NSString, value)

@interface Api (privates)
- (NSString *)slash:(NSString *)bit;
@end
@implementation Api

- (void)dealloc {
    [base release];
    [super dealloc];
}

- (id)initWithBase:(NSString *)b {
    self = [super init];
    if (self) {
        base = [b retain];
    }    
    return self;
}

- (NSArray *)retrieveQueue {
    NSData *responseData = [HTTP get:[self slash:@"/api/queue"] parameters:NSDICT(@"lolbfuscation", @"api_key")];
    if (responseData) {
        NSString *s = [NSString stringWithData:responseData];
        NSArray *parsedObject = [JSON parse:s];
        return [parsedObject mapOption:functionP(NSDictionaryToFilm)];
    } else {
        return [NSArray array];
    }
}

- (AuthenticationResponse *)authenticate:(AccessToken *)token {
    __unused NSData *responseData = [HTTP get:[self slash:@"/api/login"] parameters:EMPTY_DICT];
    return [AuthenticationResponse value:@"Not implemented yet."];
}

+ (Api *)localhost {
    return [[[self alloc] initWithBase:@"http://goodfil.ms"] autorelease];
}

#pragma mark privates

- (NSString *)slash:(NSString *)bit {
    return [base stringByAppendingPathComponent:bit];
}

@end
