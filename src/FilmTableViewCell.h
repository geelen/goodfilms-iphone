#import <Foundation/Foundation.h>
#import "Film.h"

@interface FilmTableViewCell : NSObject

+ (void)prepare:(UITableViewCell *)cell;

+ (void)display:(Film *)film onCell:(UITableViewCell *)cell;

@end
