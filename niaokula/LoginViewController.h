//
//  LoginViewController.h
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
