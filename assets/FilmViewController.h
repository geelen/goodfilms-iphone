#import <UIKit/UIKit.h>
#import "Film.h"
#import "EGOImageButton.h"
#import "FilmStub.h"

@interface FilmViewController : UITableViewController

@property (readwrite, retain) NSNumber *filmId;

@property (readwrite, retain) IBOutlet UILabel *titleLabel;
@property (readwrite, retain) IBOutlet EGOImageButton *imageView;
@property (readwrite, retain) IBOutlet UIButton *queueAction;
@property (readwrite, retain) IBOutlet UIButton *seenIt;

+ (void)pushFilm:(FilmStub *)stub onNavigationController:(UINavigationController *)navigationController;
@end
