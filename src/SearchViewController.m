#import "SearchViewController.h"
#import "FilmTableViewCell.h"
#import "FilmViewController.h"
#import "Api.h"

NewType2Implementation(SearchState, NSArray, results, NSString, term);

@interface SearchViewController ()
@property (readwrite, retain) SearchState *state;
@property (readwrite, assign) BOOL isLoading;
@end

@implementation SearchViewController

@synthesize tableView, searchBar, state, loadingView, isLoading;

- (void)dealloc {
    [state release];
    [tableView release];
    [searchBar release];
    [loadingView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [FilmTableViewCell prepareTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.state ? (self.state.results.count ?: 1)  : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state && self.state.results.count == 0) {
        static NSString *NoResultsIdent = @"NoResultsCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NoResultsIdent];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoResultsIdent] autorelease];
        }
        cell.textLabel.text = @"No results found.";
        return cell;
    } else {
        FilmStub *f = [self.state.results objectAtIndex:indexPath.row];
        return [FilmTableViewCell cellForFilmStub:f forTableView:self.tableView];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (state.results.count) {
        [FilmViewController pushFilm:[self.state.results objectAtIndex:indexPath.row] onNavigationController:self.navigationController];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FilmTableViewCell cellHeight];
}

#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = self.searchBar.text;
    if (self.searchBar.text.length < 2) {
        return;
    }
    self.state = nil;
    loadingView.hidden = NO;
    [self.searchBar resignFirstResponder];
    self.isLoading = YES;
    
    dispatch_async([Api apiQueue], ^{
        FKEither *r = [Api search:searchText];
        self.state = [SearchState results:[r.right orValue:EMPTY_ARRAY]  term:searchText];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isLoading = NO;
            [self.tableView reloadData];
            self.loadingView.hidden = YES;
//            [headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        });
    });
}
@end
