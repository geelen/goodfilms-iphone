//
//  goodfilmsAppDelegate.m
//  goodfilms
//
//  Created by Glen Maddern on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "Film.h"

#import "goodfilmsAppDelegate.h"

@implementation goodfilmsAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize rootController, queueViewController, searchViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // TODO Pull this out into a separate controller subclass.
    UIViewController *signInPage = [[[UIViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    signInPage.title = @"Sign in";
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(makeSignInOccur) forControlEvents:UIControlEventTouchUpInside];
    
    signInButton.frame = CGRectMake(0, 0, 200, 100);
    [signInPage.view addSubview:signInButton];
    
    self.rootController = [[[UINavigationController alloc] initWithRootViewController:signInPage] autorelease];
    [self.rootController setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.rootController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)makeSignInOccur {
    User *u = [[User alloc] init];
    queueViewController.user = u;
    [self.rootController pushViewController:self.tabBarController animated:YES];
}

- (void)signOut {
    [self.rootController popViewControllerAnimated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
