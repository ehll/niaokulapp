//
//  PostViewController.m
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "PostViewController.h"
#import "NSDictionary+URLQuery.h"

NSString * const kPostURL = @"https://www.niaowo.me/topics.json";
NSString * const kReplyURL = @"https://www.niaowo.me/comments.json";

@interface PostViewController ()

- (void)postAction:(id)sender;

@end

@implementation PostViewController

- (void)postAction:(id)sender
{
  NSString *title = [self.titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if ([title length] == 0 && _postType == PostTypeNew) {
    return;
  }
  NSString *content = [[self.contentField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if ([content length] == 0) {
    return;
  }
  
  NSURL *url = nil;
  NSDictionary *params = nil;
  if (_postType == PostTypeNew) {
    url = [NSURL URLWithString:kPostURL];
    params = @{@"title" : title,@"body":content};
  } else if (_postType == PostTypeReply) {
    NSAssert(_topicId, @"incorrect topic id");
    url = [NSURL URLWithString:kReplyURL];
    params = @{@"topic" : _topicId,@"body":content};
  }
  
  NSAssert(url, @"incorrect post type nil url.");
  [NSURL URLWithString:kPostURL];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  NSData *body = [[params queryString] dataUsingEncoding:NSUTF8StringEncoding];
  [request setHTTPMethod:@"POST"];
  NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody:body];
  
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *response,NSData *data,NSError *err){
                           NSLog(@"%@",response);
                           NSHTTPURLResponse *httpres = (NSHTTPURLResponse *)response;
                           NSString *responseString = [[NSString alloc] initWithData:data
                                                                            encoding:NSUTF8StringEncoding];
                           NSLog(@"data:%@",responseString);
                           NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:NSJSONReadingAllowFragments
                                                                                    error:nil];
//                           if ([[result objectForKey:@"status"] isEqualToString:@"success"]) {
                           if([httpres statusCode] == 200){
                             dispatch_async(dispatch_get_main_queue(), ^(){
//                               [appDelegate showMain];
                               if (self.delegate && [self.delegate respondsToSelector:@selector(refreshData:)]) {
                                 [self.delegate performSelector:@selector(refreshData:) withObject:result];
                               }
                               [self dismissModalViewControllerAnimated:YES];
                             });
                           }
                         }];
}

- (void)cancelAction:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}

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
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                            target:self
                                                                            action:@selector(cancelAction:)];
  self.navigationItem.leftBarButtonItem = backItem;
  
  UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(postAction:)];
  self.navigationItem.rightBarButtonItem = postItem;
  if (_postType == PostTypeReply) {
    self.titleField.hidden = YES;
    CGRect frame = self.titleField.frame;
    frame.size.height = 0;
    self.titleField.frame = frame;
  } else if (_postType == PostTypeNew) {
    self.titleField.hidden = NO;
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setTitleField:nil];
  [self setContentField:nil];
  [super viewDidUnload];
}
@end
