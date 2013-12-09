//
//  BasicLabel.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger{
    HeaderTitle = 0,
    EditProfileHeaderTitle,
    EditThumbnailMaskLabel,
    LoginTitle,
    ConversationName,
    ConversationTime,
    ShowComadParticipationTitle,
    ShowUserName,
    ShowUserComadId,
    ShowUserOccupation,
    AddFriendMenuLabel,
    AddFriendCreateGroup,
    TableHeader,
    FriendCellName,
    GroupNameLabel,
    SelectPeopleHeader,
    BlueTitle,
    ComadCellTitle,
    GrayLabel,
    ComadId,
    AddComadLabel,
    TimeAndLocationLabel,
    NoConversationText,
    OtherLabel,
    PlaceHolder
}BasicLabelName;

@interface BasicLabel : UILabel
- (id)initWithName:(BasicLabelName)name;
@end
