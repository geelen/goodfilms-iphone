
@interface Film : NSObject

@property (readonly) NSString *title;
@property (readonly) NSString *year;

+ (Film *)filmWithTitle:(NSString *)title year:(NSString *)year;
@end
