#import "Api.h"
#import "FilmStub.h"
#import "Film.h"
#import "JSON.h"
#import "HTTP.h"

NewTypeImplementation(AccessToken, NSString, value)

@interface Api (privates)
+ (NSString *)slash:(NSString *)bit;
@end

@implementation Api

+ (FKEither *)retrieveQueue {
    FKEither *responseData = [HTTP get:[self slash:@"queue"] parameters:EMPTY_DICT];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseAndCheck:)];
#ifdef TESTING_QUEUE
    [jsonResponse class]; // No op to prevent warning.
    return [FKEither rightWithValue:TESTING_QUEUE];
#else
    return [jsonResponse.right map:functionTS([self classAsId], parseFilms:)];
#endif
}

+ (FKEither *)search:(NSString *)term {
    FKEither *responseData = [HTTP get:[self slash:@"search"] parameters:NSDICT(term, @"q")];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseAndCheck:)];
    
#ifdef TESTING_QUEUE
    [jsonResponse class]; // No op to prevent warning.
    return [FKEither rightWithValue:TESTING_QUEUE];
#else
    return [jsonResponse.right map:functionTS([self classAsId], parseFilms:)];
#endif
}

+ (FKEither *)authenticate:(AccessToken *)token {
    FKEither *responseData = [HTTP post:[self slash:@"login"] parameters:NSDICT(token.value, @"access_token")];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseAndCheck:)];
#ifdef TESTING_AUTH_OK
    [jsonResponse class]; // suppresses unused variable warning
    return [FKEither rightWithValue:EMPTY_DICT];
#else
    return jsonResponse;
#endif
}

+ (FKEither *)retrieveFilm:(NSNumber *)ident {
    FKEither *responseData = [HTTP get:[self slash:[NSString stringWithFormat:@"film/%@", ident]] parameters:EMPTY_DICT];
    FKEither *jsonResponse = [responseData.right bind:functionTS([self classAsId], parseAndCheck:)];
#ifdef TESTING_FILM
    [jsonResponse class]; // suppresses unused variable warning
    return [FKEither rightWithValue:TESTING_FILM];
#else
    return [jsonResponse.right bind:functionTS([self classAsId], parseFilm:)];
#endif
}

+ (dispatch_queue_t)apiQueue {
    return dispatch_get_global_queue(0, 0);
}

#pragma mark privates

+ (FKEither *)parseJson:(NSData *)input {
    NSString *s = [NSString stringWithData:input];
    return [[JSON parse:s] toEitherWithError:@"Unexpected response from goodfilms."];
}

+ (FKEither *)parseAndCheck:(NSData *)input {
    return [[[self parseJson:input] right] bind:functionTS([self classAsId], checkForErrors:)];
}

#define LOGIN_FAIL_MESSAGE @"Couldn't login to Goodfilms."

+ (FKEither *)checkForErrors:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Expected a json object back from the API, got %@", dictionary);
        return [FKEither errorWithReason:@"login failed" description:LOGIN_FAIL_MESSAGE];
    }
    NSString *errorCode = [dictionary objectForKey:@"error"];
    if (errorCode) {
        NSString *message = [dictionary objectForKey:@"message"] ?: LOGIN_FAIL_MESSAGE;
        return [FKEither errorWithReason:@"login failed" description:message];
    }
    return [FKEither rightWithValue:dictionary];
}

+ (NSArray *)parseFilms:(NSDictionary *)payload {
    NSArray *films = [payload objectForKey:@"films"] ?: EMPTY_ARRAY;
    return [films mapOption:functionP(NSDictionaryToFilmStub)];
}

+ (FKEither *)parseFilm:(NSDictionary *)payload {
    NSString *errorMessage = @"Expected a film back from the API, but got something different.";
    NSDictionary *p = [payload objectForKey:@"film"];
    return p ? [NSDictionaryToFilm(p) toEitherWithError:errorMessage] : [FKEither errorWithReason:errorMessage];
}

+ (NSString *)slash:(NSString *)bit {
    return [@"http://goodfil.ms/api/1" stringByAppendingPathComponent:bit];
}

@end
