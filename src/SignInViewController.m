#import "SignInViewController.h"

NewTypeImplementation(AccessToken, NSString, value);

@implementation SignInViewController

@synthesize signInButton, signInSuccess, facebook;

- (void)dealloc {
    [signInButton release];
    [signInSuccess release];
    [facebook release];
    [super dealloc];
}

- (SignInViewController *)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        facebook = [[Facebook alloc] initWithAppId:kFacebookAppId andDelegate:self];
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    signInButton.backgroundColor = HEXCOLOR(0x333333ff);
    signInButton.layer.cornerRadius = 5.0f;
    self.title = @"Sign in";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark actions
- (IBAction)makeSignInOccur:(id)sender {
    [facebook authorize:EMPTY_ARRAY];
}

#pragma mark FBSessionDelegate
- (void)fbDidLogin {
    signInSuccess([AccessToken value:facebook.accessToken]);
}
@end
