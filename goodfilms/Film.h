
@interface Film : NSObject

@property (readonly) NSString *title;

+ (Film *)filmWithTitle:(NSString *)title;
@end
