#import "SBJSON.h"
#import "Api.h"
#import "Film.h"

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

- (NSURL *)baseUrl {
    return [NSURL URLWithString:base];
}

- (NSArray *)queueForUser:(User *)user {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"/api/user/1/queue?api_key=lolbfuscation" relativeToURL:[self baseUrl]]];
    
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *s = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    if (responseData) {
        SBJSON *parser = [SBJSON new];
        NSArray *parsedObject = [parser objectWithString:s error:&error];
        NSMutableArray *result = [NSMutableArray array];
        for (NSDictionary *filmData in parsedObject) {
            NSLog(@"%@", filmData);
            NSString *title = [filmData objectForKey:@"title"];
            NSString *year = [[filmData objectForKey:@"year"] description];
            if (title && year) {
                [result addObject:[Film filmWithTitle:title year:year]];
            }
        }
        [parser release];
        return result;
    } else {
        NSLog(@"%@", error);
        return [NSArray array];
    }
}

+ (Api *)localhost {
    return [[[self alloc] initWithBase:@"http://localhost:3000"] autorelease];
}
@end
