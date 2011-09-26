#import "JSON.h"
#import "SBJSON.h"

@implementation JSON

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ parse:(NSString *)raw {
    NSError *error = NULL;
    SBJSON *parser = [SBJSON new];
    NSArray *parsedObject = [parser objectWithString:raw error:&error];
    [parser release];
    return parsedObject;
}

@end
