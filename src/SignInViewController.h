#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "Api.h"

#define kFacebookAppId @"172347429470735"

typedef void(^SignInSuccess)();
typedef void(^SignInFailure)(NSString *message);

@interface SignInViewController : UIViewController <UITextFieldDelegate, FBSessionDelegate> {
    Facebook *facebook;
}

@property (readwrite, retain) IBOutlet UIButton *signInButton;
@property (readwrite, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (readwrite, copy) SignInSuccess signInSuccess;
@property (readwrite, copy) SignInFailure signInFailure;
@property (readonly) Facebook *facebook;

@end
