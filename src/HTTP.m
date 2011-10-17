#import "HTTP.h"

NSString *escape(NSString *textToEncode);

NSString *escape(NSString *textToEncode) {
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                  (CFStringRef)textToEncode,
                                                                  NULL, 
                                                                  (CFStringRef)@";/?:@&=+$,", 
                                                                  kCFStringEncodingUTF8);
    return [(NSString *)encoded autorelease];
}

@implementation HTTP

+ (NSString *)queryString:(NSDictionary *)parameters {
    NSMutableString *result = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (result.length > 0) {
            [result appendString:@"&"];
        }
        // TODO: escape the keys and values
        [result appendString:[NSString stringWithFormat:@"%@=%@", escape(key), escape(value)]];
    }];
    return result;
}

+ (FKEither *)hit:(NSString *)stringUrl request:(void (^)(NSMutableURLRequest *request))configure {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];    
    configure(request);
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *r = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        return [FKEither leftWithValue:error];
    } else {
        return [FKEither rightWithValue:r];
    }
}

+ (FKEither *)get:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSString *queryString = [self queryString:parameters];
    return [self hit:[NSString stringWithFormat:@"%@?%@", urlString, queryString] request:^(NSMutableURLRequest *request) {
        [request setHTTPMethod:@"GET"];
    }];
}

+ (FKEither *)post:(NSString *)urlString parameters:(NSDictionary *)parameters {
    return [self hit:urlString request:^(NSMutableURLRequest *request) {
        NSString *queryString = [self queryString:parameters];
        NSLog(@"Post body\n%@", queryString);
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
    }];
}
@end
