//
//  AppDelegate.m
//  niaokula
//
//  Created by he on 12-10-26.
//  Copyright (c) 2012年 he. All rights reserved.
//  user:niaokulapp
//  pass:fuckkula

#import "AppDelegate.h"

#import "ViewController.h"
#import "LoginViewController.h"

const NSString *kAPIKey = @"7a668c3ce74f4123bbdd729f2a241b1a";
const NSString *kAPISecret = @"dcea8f0378ab4b428b20ffaadd103d7e";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
//  for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
//    NSLog(@"%@",cookie);
//  }
//  [self showLogin];
  [self showMain];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 
- (void)showLogin
{
  self.loginViewCtr = [[LoginViewController alloc] initWithNibName:@"LoginViewController"
                                                            bundle:nil];
  self.window.rootViewController = self.loginViewCtr;
}

- (void)showMain
{
  self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  self.nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
  self.window.rootViewController = self.nav;
}

@end
