#import <UIKit/UIKit.h>
#import "Film.h"
#import "EGOImageButton.h"

@interface FilmViewController : UITableViewController

@property (readwrite, retain) NSNumber *filmId;

@property (readwrite, retain) IBOutlet UILabel *titleLabel;
@property (readwrite, retain) IBOutlet EGOImageButton *imageView;
@property (readwrite, retain) IBOutlet UIButton *queueAction;
@property (readwrite, retain) IBOutlet UIButton *seenIt;
@end
