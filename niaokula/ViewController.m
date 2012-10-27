//
//  ViewController.m
//  niaokula
//
//  Created by he on 12-10-26.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *topics;

@end

@implementation ViewController

- (void)loginAction:(id)sender
{
  LoginViewController *viewCtr = [[LoginViewController alloc] init];
  [self.navigationController pushViewController:viewCtr animated:YES];
}

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
                             NSArray *arr = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:NSJSONReadingMutableContainers
                                                                              error:nil];
                             self.topics = arr;
                             NSLog(@"%@",arr);
                             dispatch_async(dispatch_get_main_queue(), ^(){ [self.tableView reloadData];});
                           }

                           NSLog(@"error:%@",err);}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                               target:self
                                                                               action:@selector(loginAction:)];
  self.navigationItem.leftBarButtonItem = loginButton;
  
  UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                 action:@selector(refreshAction:)];
  self.navigationItem.rightBarButtonItem = refreshButton;
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView];
  

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
  }
  NSDictionary *dict = [self.topics objectAtIndex:indexPath.row];
  cell.textLabel.text = [dict objectForKey:@"title"];
  cell.detailTextLabel.text = [dict objectForKey:@"body"];
  
  return cell;
}

@end
