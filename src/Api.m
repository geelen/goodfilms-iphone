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

- (NSArray *)queueForUser:(User *)user {
    return [NSArray arrayWithObjects:[Film filmWithTitle:@"1"], nil];
}

@end
