#import "FilmViewController.h"
#import "Api.h"

@interface FilmViewController ()
@property (readwrite, retain) Film *film;
@property (readwrite, retain) NSArray *attributes;
@end

@implementation FilmViewController

@synthesize titleLabel, imageView, queueAction, seenIt, film, attributes, filmId;

- (void)dealloc {
    [attributes release];
    [queueAction release];
    [seenIt release];
    [titleLabel release];
    [imageView release];
    [film release];
    [filmId release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.attributes = [Film attributesToShow];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async([Api apiQueue], ^{
        FKEither *r = [Api retrieveFilm:filmId];
        if (r.isRight) {
            self.film = r.right.value;
            dispatch_async(dispatch_get_main_queue(), ^{
                titleLabel.text = film.title;
                imageView.imageURL = film.imageURL;
                [self.tableView reloadData];
            });
        }
    });

        
    if (rand() % 2 == 0) {
        [queueAction setTitle:@"Add to queue" forState:UIControlStateNormal];
        [queueAction addTarget:self action:@selector(addToQueue:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [queueAction setTitle:@"Remove from queue" forState:UIControlStateNormal];        
        [queueAction addTarget:self action:@selector(removeFromQueue:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return attributes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FilmDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.numberOfLines = 2;
    }
    
    // Configure the cell...
    NSString *key = [attributes objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = [film.metadata objectForKey:key]; 
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


#pragma Button actions

- (IBAction)addToQueue:(id)sender {
    NSLog(@"add");
}

- (IBAction)removeFromQueue:(id)sender {
    NSLog(@"remove");    
}

- (IBAction)seenIt:(id)sender {
    NSLog(@"seen it");
}

- (void)dismissImage {
    [self dismissModalViewControllerAnimated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (IBAction)showImageFullscreen:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    UIViewController *vc = [[[UIViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [vc.view addSubview:^{
        EGOImageButton *b = [[[EGOImageButton alloc] initWithPlaceholderImage:nil] autorelease];
        b.frame = CGRectMake(0, 0, 320, 480);
        b.imageURL = film.imageURL;
        [b setAdjustsImageWhenHighlighted:NO];
        [b addTarget:self action:@selector(dismissImage) forControlEvents:UIControlEventTouchUpInside];
        return b;
    }()];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:vc animated:YES];
}

+ (void)pushFilm:(FilmStub *)stub onNavigationController:(UINavigationController *)navigationController {
    FilmViewController *detailViewController = [[FilmViewController alloc] initWithNibName:@"FilmViewController" bundle:nil];
    detailViewController.filmId = stub.id;
    [navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
@end
