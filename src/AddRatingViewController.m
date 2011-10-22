#import "AddRatingViewController.h"
#import "EGOImageView.h"

@interface AddRatingViewController () {
    BOOL hasSetQuality;
    BOOL hasSetRewatchability;
}
@end

@implementation AddRatingViewController
@synthesize filmTitle;
@synthesize qualityInfo;
@synthesize rewatchabilityInfo;
@synthesize rateIt;
@synthesize quality, rewatchability;
@synthesize film, delegate;

- (void)dealloc {
    [quality release];
    [rewatchability release];
    [film release];
    [filmTitle release];
    [qualityInfo release];
    [rewatchabilityInfo release];
    [rateIt release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)v:(float)a {
    float x = a * 5.0;
    return [NSString stringWithFormat:@"%2f", x]; 
}

- (void)changeRateState {
    rateIt.enabled = hasSetQuality && hasSetRewatchability;
}

- (IBAction)sendRating:(id)sender {
    [delegate rate:film withRating:[Rating qualityValue:quality.value rewatchabilityValue:rewatchability.value]];
}

- (IBAction)qualityChanged:(id)sender {
    hasSetQuality = YES;
    qualityInfo.text = [self v:quality.value];
    [self changeRateState];
}

- (IBAction)rewatchabilityChanged:(id)sender {
    hasSetRewatchability = YES;
    rewatchabilityInfo.text = [self v:rewatchability.value];
    [self changeRateState];
}

#pragma mark - View lifecycle

- (void)dismissMe {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissMe)] autorelease];
    
    self.view.backgroundColor = HEXCOLOR(0x333333ff);
    
    EGOImageView *back = [[[EGOImageView alloc] initWithFrame:self.view.frame] autorelease];
    back.imageURL = film.imageURL;
    back.placeholderImage = [UIImage imageNamed:@"45-movie-1.png"];
    [self.view addSubview:back];
    [self.view sendSubviewToBack:back];
}

- (void)viewDidUnload {
    [self setFilmTitle:nil];
    [self setQualityInfo:nil];
    [self setRewatchabilityInfo:nil];
    [self setRateIt:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.filmTitle.text = film.title;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
