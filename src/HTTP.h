#import <Foundation/Foundation.h>



@interface HTTP : NSObject

+ (FKEither *)get:(NSString *)urlString parameters:(NSDictionary *)parameters;

+ (FKEither *)post:(NSString *)urlString parameters:(NSDictionary *)parameters;

@end
