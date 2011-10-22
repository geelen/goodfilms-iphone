#import <Foundation/Foundation.h>
#import "FilmStub.h"

@interface FilmTableViewCell : NSObject
+ (UITableViewCell *)cellForFilmStub:(FilmStub *)stub forTableView:(UITableView *)tableView;

+ (void)prepare:(UITableViewCell *)cell;

+ (void)prepareTableView:(UITableView *)tableView;

+ (void)display:(FilmStub *)stub onCell:(UITableViewCell *)cell;

+ (CGFloat)cellHeight;
@end
