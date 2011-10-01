#import "HTTP.h"

@implementation HTTP
+ (NSString *)queryString:(NSDictionary *)parameters {
    NSMutableString *result = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (result.length > 0) {
            [result appendString:@"&"];
        }
        // TODO: escape the keys and values
        [result appendString:[NSString stringWithFormat:@"%@=%@", key, value]];
    }];
    return result;
}

+ (NSData *)hit:(NSString *)stringUrl request:(void (^)(NSMutableURLRequest *request))configure {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];    
    configure(request);
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}


+ (NSData *)get:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSString *queryString = [self queryString:parameters];
    return [self hit:[NSString stringWithFormat:@"%@?%@", urlString, queryString] request:^(NSMutableURLRequest *request) {
        [request setHTTPMethod:@"get"];
    }];
}

+ (NSData *)post:(NSString *)urlString parameters:(NSDictionary *)parameters {
    return [self hit:urlString request:^(NSMutableURLRequest *request) {
        NSString *queryString = [self queryString:parameters];
        [request setHTTPMethod:@"post"];
        [request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
    }];
}
@end
