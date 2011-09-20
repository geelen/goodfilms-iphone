#import <UIKit/UIKit.h>
#import "User.h"
#import "FBConnect.h"

#define kFacebookAppId @"172347429470735"

NewTypeInterface(AccessToken, NSString, value);

typedef void(^SignInSuccess)(AccessToken *);

@interface SignInViewController : UIViewController <UITextFieldDelegate, FBSessionDelegate> {
    Facebook *facebook;
}

@property (readwrite, retain) IBOutlet UIButton *signInButton;
@property (readwrite, copy) SignInSuccess signInSuccess;
@property (readonly) Facebook *facebook;

- (SignInViewController *)initWithFacebook:(Facebook *)fb;

@end
