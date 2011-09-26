#import "QueueViewController.h"
#import "Film.h"
#import "Api.h"
#import "EGOImageView.h"
#import "FilmViewController.h"

@implementation QueueViewController

@synthesize user;

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
    [self.tableView reloadData];
    [self performSelectorInBackground:@selector(loadQueue) withObject:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return user.queue.count;
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

    Film *film = [user.queue objectAtIndex:indexPath.row];
    
    titleLabel.text = film.title;
    subtitleLabel.text = film.year.description;
    imageView.imageURL = film.imageURL;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    FilmViewController *detailViewController = [[FilmViewController alloc] initWithNibName:@"FilmViewController" bundle:nil];
    detailViewController.film = [user.queue objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}


#pragma Queue loading
- (void)loadQueue {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    user.queue = [[Api localhost] retrieveQueue];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [pool release];
}
@end
