//
//  ShowUserList.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/25.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowUserList : UIView {
    UIView *content;
    UILabel *contentLabel;
}

- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;
@end
