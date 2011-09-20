#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "QueueViewController.h"
#import "SignInViewController.h"
#import "FBConnect.h"

@interface goodfilmsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet SearchViewController *searchViewController;
@property (nonatomic, retain) IBOutlet QueueViewController *queueViewController;
@property (nonatomic, retain) UINavigationController *rootController;
@property (nonatomic, retain) SignInViewController *signInViewController;

@end
