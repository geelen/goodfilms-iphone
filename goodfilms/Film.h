
@interface Film : NSObject

@property (readonly) NSString *title;

+ (Film *)movieWithTitle:(NSString *)title;
@end
