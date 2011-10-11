#import "QueueViewController.h"
#import "FilmStub.h"
#import "Api.h"
#import "FilmViewController.h"
#import "FilmTableViewCell.h"

@interface QueueViewController ()
@property (readwrite, retain) NSArray *films;
@property (readwrite, assign) BOOL isLoading;
@end

@implementation QueueViewController {
    EGORefreshTableHeaderView *headerView;
}

@synthesize films, isLoading;

- (void)dealloc {
    [films release];
    [headerView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    view.delegate = self;
    [self.tableView addSubview:view];
    headerView = view;

    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)triggerLoad {
    dispatch_async([Api apiQueue], ^{
        self.isLoading = YES;
        sleep(3);
        FKEither *r = [Api retrieveQueue];
        self.films = [r.right orValue:EMPTY_ARRAY];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isLoading = NO;
            [self.tableView reloadData];
            [headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self triggerLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return films.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [FilmTableViewCell prepare:cell];
    }
    
    FilmStub *film = [films objectAtIndex:indexPath.row];
    [FilmTableViewCell display:film onCell:cell];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilmViewController *detailViewController = [[FilmViewController alloc] initWithNibName:@"FilmViewController" bundle:nil];
    FilmStub *film = [films objectAtIndex:indexPath.row];
    detailViewController.filmId = film.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[headerView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{    
//    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	[headerView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGO Pull Table Thing

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self triggerLoad];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return self.isLoading;
}

@end
