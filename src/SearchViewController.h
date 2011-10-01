#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (readwrite, retain) IBOutlet UITableView *tableView;
@property (readwrite, retain) IBOutlet UISearchBar *searchBar;

@end
