//
//  AppDelegate.h
//  niaokula
//
//  Created by he on 12-10-26.
//  Copyright (c) 2012年 he. All rights reserved.
//
//  niaokula:
//  api key是7a668c3ce74f4123bbdd729f2a241b1a
//  secret是dcea8f0378ab4b428b20ffaadd103d7e
#import <UIKit/UIKit.h>


extern NSString * const kAPIKey;
extern NSString * const kAPISecret;

@class ViewController;
@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) LoginViewController *loginViewCtr;

@property (strong, nonatomic) UINavigationController *nav;

- (void)showLogin;
- (void)showMain;
@end

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)