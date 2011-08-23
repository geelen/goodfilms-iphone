
@interface Movie : NSObject

@property (readonly) NSString *title;

+ (Movie *)movieWithTitle:(NSString *)title;
@end
