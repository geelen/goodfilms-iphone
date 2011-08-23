#import "Film.h"

@implementation Film

@synthesize title, year;

- (void)dealloc {
    [title release];
    [year release];
    [super dealloc];
}

- (id)initWithTitle:(NSString *)t year:(NSString *)y;
{
    self = [super init];
    if (self) {
        title = [t retain];
        year = [y retain];
    }
    return self;
}

+ (Film *)filmWithTitle:(NSString *)title year:(NSString *)year {
    return [[[self alloc] initWithTitle:title year:(NSString *)year] autorelease];
}
@end
