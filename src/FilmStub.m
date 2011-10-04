#import "FilmStub.h"

NewType4Implementation(FilmStub, NSNumber, id, NSString, title, NSNumber, year, NSString, image_url)

@implementation FilmStub (more)

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.image_url];
}

@end