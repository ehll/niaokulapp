//
//  LoginViewController.m
//  niaokula
//
//  Created by he on 12-10-26.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.niaowo.me/account/sign_in"]]];
  [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
