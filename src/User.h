#import <Foundation/Foundation.h>

@interface User : NSObject

// Contains Films

@property (readwrite, retain) NSArray *queue;
@property (readwrite, retain) NSString *wat;

- (id)initWithId:(NSString *)i;
@end
