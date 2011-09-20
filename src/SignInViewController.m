#import "SignInViewController.h"
#import "FBConnect.h"

@implementation CustomField
- (void) drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:rect];
}
@end

@implementation SignInViewController

@synthesize fieldContainer, emailField, signInButton, signInSuccess;

- (void)dealloc {
    [fieldContainer release];
    [emailField release];
    [signInButton release];
    [signInSuccess release];
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

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    fieldContainer.backgroundColor = HEXCOLOR(0x181818ff);
    fieldContainer.layer.borderColor = [HEXCOLOR(0x585858ff) CGColor];
    fieldContainer.layer.borderWidth = 1.0f;
    fieldContainer.layer.cornerRadius = 5.0f;
    
    signInButton.backgroundColor = HEXCOLOR(0x333333ff);

    signInButton.layer.cornerRadius = 5.0f;
    
    self.title = @"Sign in";
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(back)] autorelease];

}

- (IBAction)makeSignInOccur:(id)sender {
    User *u = [[User alloc] initWithId:self.emailField.text];
    signInSuccess(u);
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self makeSignInOccur:nil];
    return YES;
}
@end
