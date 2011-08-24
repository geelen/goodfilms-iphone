#import "Film.h"

NewType3Implementation(Film, NSString, title, NSNumber, year, NSString, image_url)

@implementation Film (more)

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.image_url];
}

@end