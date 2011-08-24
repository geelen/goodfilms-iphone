#import "Film.h"

NewType4Implementation(Film, NSString, title, NSNumber, year, NSString, image_url, NSDictionary, metadata)

@implementation Film (more)

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.image_url];
}

+ (NSArray *)attributesToShow {
    return [NSArray arrayWithObjects:@"director", @"starring", @"runtime", nil];
}
@end