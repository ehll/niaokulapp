//
//  TopicViewController.m
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController ()

@property (nonatomic, strong) NSDictionary *contents;

- (void)reloadData;

@end

@implementation TopicViewController

- (void)refreshAction:(id)sender
{
  NSString *urlString = [NSString stringWithFormat:@"https://www.niaowo.me/topics/%@.json",self.topicId];
  NSURL *url = [NSURL URLWithString:urlString];
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
                             self.contents = dict;
                             NSLog(@"%@",dict);
                             dispatch_async(dispatch_get_main_queue(), ^(){ [self reloadData];});
                           }
                           else {
                             NSLog(@"data:%@",responseString);
                             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:NSJSONReadingMutableContainers
                                                                                    error:nil];
                             if ([dict objectForKey:@"error"]) {
//                               [appDelegate showLogin];
                             }
                           }
                           NSLog(@"error:%@",err);}];
}

- (void)reloadData
{
  NSMutableString *httpString = [NSMutableString string];
  NSDictionary *topic = [self.contents objectForKey:@"topic"];
  [httpString appendFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, minimum-scale=1.0, initial-scale=1.0, maximum-scale=1.0, user-scalable=1\" /></head>"];
  [httpString appendFormat:@"<body><h3>%@</h3>",[topic objectForKey:@"title"]];
  [httpString appendFormat:@"%@",[topic objectForKey:@"body"]];
  [httpString appendFormat:@"--- %@<br/><hr>",[topic objectForKey:@"author"]];
  
  NSArray *comments = [self.contents objectForKey:@"comments"];
  for (NSDictionary *comment in comments) {
    NSInteger index = [comments indexOfObject:comment];
    [httpString appendFormat:@"%i 楼<br/>",index];
    [httpString appendFormat:@"%@<br/>",[comment objectForKey:@"body"]];
    [httpString appendFormat:@"--- %@<br/><hr>",[comment objectForKey:@"author"]];
  }
  [httpString appendFormat:@"</body></html>"];
  [self.contentView loadHTMLString:httpString baseURL:nil];
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
  [self refreshAction:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setContentView:nil];
  [super viewDidUnload];
}
@end
