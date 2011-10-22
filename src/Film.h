
NewType4Interface(Film, NSString, title, NSNumber, year, NSString, image_url, NSDictionary, metadata)

@interface Film (more)

- (NSURL *)imageURL;

+ (NSArray *)attributesToShow;
@end

NewType2Interface(Rating, NSNumber, quality, NSNumber, rewatchability)

@interface Rating (more)
- (float)qualityValue;
- (float)rewatchabilityValue;

+ (Rating *)qualityValue:(float)quality rewatchabilityValue:(float)rewatchability;
@end