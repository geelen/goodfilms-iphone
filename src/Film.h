
NewType4Interface(Film, NSString, title, NSNumber, year, NSString, image_url, NSDictionary, metadata)

@interface Film (more)

- (NSURL *)imageURL;

+ (NSArray *)attributesToShow;
@end

