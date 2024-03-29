//
//  ConversationTextBox.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConversationTextBoxDelegate;

@interface ConversationTextBox : UIView <UITextFieldDelegate>{
    float iOSVersion;
    UITextField *tf;
}
@property (nonatomic, weak) id<ConversationTextBoxDelegate> delegate;
@property (nonatomic, retain) UITextView *textView;

- (void)removeKeyBoard;
@end

@protocol ConversationTextBoxDelegate <NSObject>
- (void)sendClicked:(NSString *)text;
- (void)plusClicked;
@end

