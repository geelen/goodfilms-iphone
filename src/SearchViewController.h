#import <UIKit/UIKit.h>

NewType2Interface(SearchState, NSArray, results, NSString, term);

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (readwrite, retain) IBOutlet UITableView *tableView;
@property (readwrite, retain) IBOutlet UISearchBar *searchBar;
@property (readwrite, retain) IBOutlet UIView *loadingView;

@end
