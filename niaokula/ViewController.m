//
//  ViewController.m
//  niaokula
//
//  Created by he on 12-10-26.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TopicViewController.h"
#import "PostViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *topics;

@end

@implementation ViewController

- (void)refreshAction:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"https://www.niaowo.me/topics.json"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *response,NSData *data,NSError *err){
                           NSLog(@"%@",response);
                           NSString *responseString = [[NSString alloc] initWithData:data
                                                                            encoding:NSUTF8StringEncoding];
                           //                           NSLog(@"data:%@",responseString);
                           if (!err) {
                             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:NSJSONReadingMutableContainers
                                                                              error:nil];
                             self.topics = [dict objectForKey:@"topics"];
                             NSLog(@"%@",dict);
                             dispatch_async(dispatch_get_main_queue(), ^(){ [self.tableView reloadData];});
                           }
                           else {
                             NSLog(@"data:%@",responseString);
                             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:NSJSONReadingMutableContainers
                                                                                    error:nil];
                             if ([dict objectForKey:@"error"]) {
                               [appDelegate showLogin];
                             }
                           }
                           NSLog(@"error:%@",err);}];
}

- (void)postAction:(id)sender
{
  PostViewController *viewCtr = [[PostViewController alloc] initWithNibName:@"PostViewController"
                                                                     bundle:nil];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewCtr];
  [self.navigationController presentModalViewController:nav animated:YES];
}

- (void)logoutAction:(id)sender
{
  for (NSHTTPCookie *cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
  }
  [appDelegate showLogin];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                 action:@selector(refreshAction:)];
  UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"logout"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(logoutAction:)];
  UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                              target:self
                                                                              action:@selector(postAction:)];
  
  self.navigationItem.rightBarButtonItems = postButton;
  
  self.navigationItem.leftBarButtonItems = @[refreshButton,logoutButton];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.tableView];
  
  [self refreshAction:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
  }
  NSDictionary *dict = [self.topics objectAtIndex:indexPath.row];
  cell.textLabel.text = [dict objectForKey:@"title"];
  cell.detailTextLabel.text = [dict objectForKey:@"author"];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSDictionary *dict = [self.topics objectAtIndex:indexPath.row];
  NSString *topicId = [NSString stringWithFormat:@"%i",[[dict objectForKey:@"id"] integerValue]];
  TopicViewController *viewCtr = [[TopicViewController alloc] initWithNibName:@"TopicViewController"
                                                                       bundle:nil];
  viewCtr.topicId = topicId;
  [self.navigationController pushViewController:viewCtr animated:YES];
}

@end
