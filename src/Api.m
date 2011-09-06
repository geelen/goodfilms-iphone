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
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"/api/user/%@/queue?api_key=lolbfuscation", user.wat] relativeToURL:[self baseUrl]]];
    
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if (responseData) {
        NSString *s = [NSString stringWithData:responseData];
        SBJSON *parser = [SBJSON new];
        NSArray *parsedObject = [parser objectWithString:s error:&error];
        NSArray *result = [parsedObject mapOption:functionP(NSDictionaryToFilm)];
        [parser release];
        return result;
    } else {
        NSLog(@"%@", error);
        return [NSArray array];
    }
}

+ (Api *)localhost {
    return [[[self alloc] initWithBase:@"http://goodfil.ms"] autorelease];
}
@end
