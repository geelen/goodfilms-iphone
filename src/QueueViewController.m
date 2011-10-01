#import "QueueViewController.h"
#import "Film.h"
#import "Api.h"
#import "EGOImageView.h"
#import "FilmViewController.h"

@implementation QueueViewController

@synthesize films;

- (void)dealloc {
    [films release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async([Api apiQueue], ^{
        NSArray *newFilms = [Api retrieveQueue];
        self.films = newFilms;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
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

#define IMAGE_TAG 5555
#define TITLE_TAG (IMAGE_TAG+1)
#define SUBTITLE_TAG (IMAGE_TAG+2)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

        EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 90)] autorelease];
        imageView.tag = IMAGE_TAG;
        [[cell contentView] addSubview:imageView];


        [[cell contentView] addSubview:^{
            UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)] autorelease];
            l.tag = TITLE_TAG;
            l.font = [UIFont boldSystemFontOfSize:18.0f];
            return l;
        }()];

        [[cell contentView] addSubview:^{
            UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(270, 10, 50, 20)] autorelease];
            l.tag = SUBTITLE_TAG;
            l.font = [UIFont systemFontOfSize:18.0f];
            l.textColor = [UIColor grayColor];
            return l;
        }()];
    }
    
    EGOImageView *imageView = (EGOImageView *)[[cell contentView] viewWithTag:IMAGE_TAG];
    UILabel *titleLabel = (UILabel *)[[cell contentView] viewWithTag:TITLE_TAG];
    UILabel *subtitleLabel = (UILabel *)[[cell contentView] viewWithTag:SUBTITLE_TAG];

    Film *film = [films objectAtIndex:indexPath.row];
    
    titleLabel.text = film.title;
    subtitleLabel.text = film.year.description;
    imageView.imageURL = film.imageURL;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    FilmViewController *detailViewController = [[FilmViewController alloc] initWithNibName:@"FilmViewController" bundle:nil];
    detailViewController.film = [films objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}


@end
