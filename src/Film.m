#import "Film.h"

@implementation Film

@synthesize title;

- (void)dealloc {
    [title release];
    [super dealloc];
}

- (id)initWithTitle:(NSString *)t;
{
    self = [super init];
    if (self) {
        title = [t retain];
    }
    return self;
}

+ (Film *)filmWithTitle:(NSString *)title {
    return [[[self alloc] initWithTitle:title] autorelease];
}
@end
