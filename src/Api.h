#import <Foundation/Foundation.h>
#import "User.h"

@interface Api : NSObject {
    NSString *base;
}

- (NSArray *)queueForUser:(User *)user;

@end