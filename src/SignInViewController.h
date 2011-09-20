#import <UIKit/UIKit.h>
#import "User.h"

typedef void(^SignInSuccess)(User *);

@interface CustomField : UITextField 
@end

@interface SignInViewController : UIViewController <UITextFieldDelegate>

@property (readwrite, retain) IBOutlet UIView *fieldContainer;
@property (readwrite, retain) IBOutlet UITextField *emailField;
@property (readwrite, retain) IBOutlet UIButton *signInButton;

@property (readwrite, copy) SignInSuccess signInSuccess;
@end
