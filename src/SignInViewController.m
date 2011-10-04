#import "SignInViewController.h"

@interface SignInViewController (privates)
- (void)handleFacebookAuthentication:(AccessToken *)token;
@end
@implementation SignInViewController

@synthesize signInButton, signInSuccess, facebook, activityView, signInFailure;

- (void)dealloc {
    [activityView release];
    [signInButton release];
    [signInSuccess release];
    [signInFailure release];
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

- (void)viewStateInProgress {
    [activityView startAnimating];
    [signInButton setEnabled:NO];
}

- (void)resetViewState {
    [activityView stopAnimating];
    [signInButton setEnabled:YES];
}

#pragma mark actions
- (IBAction)makeSignInOccur:(id)sender {
    [self viewStateInProgress];
#ifdef TESTING_FACEBOOK_TOKEN
    [self handleFacebookAuthentication:TESTING_FACEBOOK_TOKEN];
#else
    [facebook authorize:EMPTY_ARRAY];
#endif
}

#pragma mark FBSessionDelegate
- (void)fbDidLogin {
    [self handleFacebookAuthentication:[AccessToken value:facebook.accessToken]];
}

- (void)handleFacebookAuthentication:(AccessToken *)token {
    dispatch_async([Api apiQueue], ^{
        FKEither *r = [Api authenticate:token]; 
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([r isRight]) {
                signInSuccess();
            } else {
                signInFailure([r.left.value localizedDescription]);
            }
            [self resetViewState];
        });
    });
}
@end
