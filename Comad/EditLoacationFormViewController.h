//
//  EditLoacationFormViewController.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditLocationFormDelegate;

@interface EditLoacationFormViewController : UIViewController<UITextFieldDelegate> {
    CGRect windowSize;
    float iOSVersion;
    UITextField *tf;
}
@property (nonatomic, retain)NSString *location;
@property (nonatomic, weak) id<EditLocationFormDelegate> delegate;
-(void)configure;
@end

@protocol EditLocationFormDelegate <NSObject>
- (void)changeLocation:(NSString *)changeLocation;
@end
