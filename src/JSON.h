#import <Foundation/Foundation.h>

@interface JSON : NSObject

+ (FKOption *)parse:(NSString *)raw;
@end
