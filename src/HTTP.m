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

+ (NSData *)get:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSString *queryString = [self queryString:parameters];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlString, queryString]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request setHTTPMethod:@"get"];
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

+ (NSData *)post:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSString *queryString = [self queryString:parameters];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}
@end
