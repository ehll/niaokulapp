//
//  TopicViewController.h
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicViewController : UIViewController

@property (nonatomic, copy) NSString *topicId;
@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@end
