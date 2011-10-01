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

+ (FKOption *)parse:(NSString *)raw {
    NSError *error = NULL;
    SBJSON *parser = [SBJSON new];
    id parsedObject = [parser objectWithString:raw error:&error];
    [parser release];
    if (error) {
        return [FKOption none];
    } else {
        return [FKOption some:parsedObject];
    }
}

@end
