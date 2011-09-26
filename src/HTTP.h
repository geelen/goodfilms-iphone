#import <Foundation/Foundation.h>

@interface HTTP : NSObject

+ (NSData *)get:(NSString *)urlString parameters:(NSDictionary *)parameters;

+ (NSData *)post:(NSString *)urlString parameters:(NSDictionary *)parameters;

@end
