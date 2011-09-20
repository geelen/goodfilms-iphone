#import "User.h"
#import "Film.h"

#import "goodfilmsAppDelegate.h"
#import "SignInViewController.h"

@implementation goodfilmsAppDelegate

@synthesize window = _window, tabBarController = _tabBarController;
@synthesize rootController, queueViewController, searchViewController, signInViewController;

- (void)dealloc {
    [_window release];
    [_tabBarController release];
    [rootController release];
    [queueViewController release];
    [searchViewController release];
    [signInViewController release];
    [super dealloc];
}

- (void)back {
    [rootController popViewControllerAnimated:YES];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    self.signInViewController = [[[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil] autorelease];
    
    __block goodfilmsAppDelegate *blkSelf = self;
    signInViewController.signInSuccess = ^(AccessToken *token) {
        //queueViewController.user = u;
        [blkSelf.rootController pushViewController:blkSelf.tabBarController animated:YES];
    };
    
    self.rootController = [[[UINavigationController alloc] initWithRootViewController:signInViewController] autorelease];
    [self.rootController setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.rootController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)signOut {
    [self.rootController popViewControllerAnimated:YES];
}

// Called by pre 4.2 clients.
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self application:application openURL:url sourceApplication:nil annotation:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [signInViewController.facebook handleOpenURL:url]; 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [rootController popViewControllerAnimated:NO];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     See also applicationDidEnterBackground:.
     */
}

@end
