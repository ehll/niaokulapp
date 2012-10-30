//
//  PostViewController.h
//  niaokula
//
//  Created by he on 12-10-27.
//  Copyright (c) 2012年 he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
typedef enum _PostType{
  PostTypeNew = 0,
  PostTypeReply = 1
}PostType;

@protocol PostResulting <NSObject>

@optional
- (void)refreshData:(NSDictionary *)result;

@end

@interface PostViewController : UIViewController

@property (nonatomic, assign) PostType postType;
@property (nonatomic, copy) NSString *topicId;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) id<PostResulting> delegate;
@end
