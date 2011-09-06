#import "SignInViewController.h"

@implementation CustomField

- (void) drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:rect];
//    [[UIColor darkGrayColor] setFill];
//    [[self placeholder] drawInRect:rect withFont:self.font];
}

@end

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0  \
    green:((c>>16)&0xFF)/255.0 \
    blue:((c>>8)&0xFF)/255.0 \
    alpha:((c)&0xFF)/255.0]

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
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

@end
