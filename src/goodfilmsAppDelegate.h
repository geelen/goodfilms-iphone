#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "QueueViewController.h"

@interface goodfilmsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet SearchViewController *searchViewController;

@property (nonatomic, retain) IBOutlet QueueViewController *queueViewController;

@property (nonatomic, retain) UINavigationController *rootController;

@property (nonatomic, retain) UITextField *signInField;

@end
