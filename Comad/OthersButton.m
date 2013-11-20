//
//  OthersButton.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "OthersButton.h"
#import "Image.h"

@implementation OthersButton

- (id)initWithName:(OthersButtonName)name
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 71, 90);
        switch (name) {
            case AddFriend:
                self.labelName = @"友達追加";
                self.imageName = @"OthersAddFriend.png";
                break;
            case MyPage:
                self.labelName = @"マイページ";
                self.imageName = @"OthersMyPage.png";
                break;
            case Settings:
                self.labelName = @"設定";
                self.imageName = @"OthersSettings.png";
                break;
            case Map:
                self.labelName = @"コマドスポット";
                self.imageName = @"OthersMap.png";
                break;
            case History:
                self.labelName = @"コマド履歴";
                self.imageName = @"OthersHistory.png";
                break;
            case Message:
                self.labelName = @"メッセージ";
                self.imageName = @"OthersMessage.png";
                break;
            default:
                break;
        }
        
        UIImage *BtnImage = [UIImage imageNamed:self.imageName];
        UIImage *BtnImageResize = [Image resizeImage:BtnImage resizeWidth:71 resizeHeight:71];
        [self setImage:BtnImageResize forState:UIControlStateNormal];
        
        [self setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];
        //[self setTitle:self.labelName forState:UIControlStateNormal];
    }
    return self;
}

@end
