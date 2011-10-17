#import <Foundation/Foundation.h>
#import "FilmStub.h"

@interface FilmTableViewCell : NSObject

+ (void)prepare:(UITableViewCell *)cell;

+ (void)display:(FilmStub *)stub onCell:(UITableViewCell *)cell;

+ (CGFloat)cellHeight;
@end
