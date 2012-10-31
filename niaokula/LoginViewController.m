//
//  LoginViewController.m
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "LoginViewController.h"
#import "NSDictionary+URLQuery.h"
#import "Toast+UIView.h"

static NSString * const kLoginUrl = @"https://www.niaowo.me/account/token";

@interface LoginViewController ()

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
  NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if ([username length] == 0) {
    NSLog(@"fuck username!");
    [self.usernameField becomeFirstResponder];
    return;
  }
  NSString *pass = [self.passField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if ([pass length] == 0) {
    NSLog(@"fuck pass");
    [self.passField becomeFirstResponder];
    return;
  }
  [self.view makeToastActivity];
  NSURL *url = [NSURL URLWithString:kLoginUrl];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  NSDictionary *params = @{@"api_key" : kAPIKey,@"api_secret":kAPISecret,@"username":username,@"password":pass};
  NSData *body = [[params queryString] dataUsingEncoding:NSUTF8StringEncoding];
  [request setHTTPMethod:@"POST"];
  NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody:body];

  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *response,NSData *data,NSError *err){
                           NSLog(@"%@",response);
                           NSString *responseString = [[NSString alloc] initWithData:data
                                                                            encoding:NSUTF8StringEncoding];
                           NSLog(@"data:%@",responseString);
                           NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:NSJSONReadingAllowFragments
                                                                                    error:nil];
                           dispatch_async(dispatch_get_main_queue(), ^(){
                             [self.view hideToastActivity];
                           });
                           if ([[result objectForKey:@"status"] isEqualToString:@"success"]) {
                             dispatch_async(dispatch_get_main_queue(), ^(){
                               [appDelegate showMain];
                             });
                           }
                         }];
}

@end
