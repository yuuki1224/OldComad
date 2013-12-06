//
//  EditProfileViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Basic.h"
#import "EditProfileFormViewController.h"
#import "Header.h"

@interface EditProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, EditProfileFormDelegate, HeaderDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITableView *editProfileTable;
    UIPopoverController *popover;
}
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *comadId;
@property (nonatomic, retain)NSString *occupation;

@property (nonatomic, retain)NSString *detail;
@property (nonatomic, retain)NSString *question1;
@property (nonatomic, retain)NSString *question2;
@property (nonatomic, retain)NSString *question3;
@property (nonatomic, retain)NSString *question4;
-(void)configure;
@end
