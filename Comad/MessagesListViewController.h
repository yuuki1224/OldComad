//
//  MessagesListViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/14.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Basic.h"
#import "Header.h"

@interface MessagesListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HeaderDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITableView *messageListView;
    NSMutableArray *friendsArray;
}

-(void)configure;
@end
