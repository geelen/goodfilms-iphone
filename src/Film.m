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

NewType2Implementation(Rating, NSNumber, quality, NSNumber, rewatchability)

@implementation Rating (more)

- (float)qualityValue {
    return [self.quality floatValue];
}

- (float)rewatchabilityValue {
    return [self.rewatchability floatValue];
}

+ (Rating *)qualityValue:(float)quality rewatchabilityValue:(float)rewatchability {
    return [self quality:[NSNumber numberWithFloat:quality] rewatchability:[NSNumber numberWithFloat:rewatchability]];
}
@end
