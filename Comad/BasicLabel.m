//
//  BasicLabel.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/03.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "BasicLabel.h"

@implementation BasicLabel

- (id)initWithName:(BasicLabelName)name {
    
    self = [super init];
    if (self) {
        // Initialization code
        switch (name) {
            case HeaderTitle:{
                self.textColor = [UIColor colorWithRed:0.188 green:0.239 blue:0.314 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
                self.font = font;
                self.backgroundColor = [UIColor colorWithRed:0.298 green:0.541 blue:0.925 alpha:1.0];
                break;
            }
            case EditProfileHeaderTitle:{
                self.textColor = [UIColor colorWithRed:0.427 green:0.427 blue:0.447 alpha:1.0];
                self.backgroundColor = [UIColor colorWithRed:0.894 green:0.902 blue:0.906 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                break;
            }
            case EditThumbnailMaskLabel:{
                self.textColor = [UIColor whiteColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
                self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
                self.font = font;
                break;
            }
            case LoginTitle:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:20.0f];
                self.font = font;
                break;
            }
            case ConversationName:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f];
                self.font = font;
                break;
            }
            case ConversationTime:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0f];
                self.font = font;
                break;
            }
            case ShowComadParticipationTitle:{
                self.textColor = [UIColor colorWithRed:0.678 green:0.698 blue:0.733 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0f];
                self.font = font;
                break;
            }
            case ShowUserName:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18.0f];
                self.font = font;
                break;
            }
            case ShowUserComadId:{
                self.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                break;
            }
            case ShowUserOccupation:{
                self.textColor = [UIColor colorWithRed:0.133 green:0.384 blue:0.561 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                break;
            }
            case AddFriendMenuLabel:{
                self.textColor = [UIColor whiteColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                self.backgroundColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
                break;
            }
            case AddFriendCreateGroup:{
                self.textColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:16.0f];
                self.font = font;
                self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
                break;
            }
            case TableHeader:{
                self.textColor = [UIColor colorWithRed:0.678 green:0.698 blue:0.733 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                self.backgroundColor = [UIColor colorWithRed:0.965 green:0.969 blue:0.973 alpha:1.0];
                break;
            }
            case FriendCellName:{
                self.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:15.0f];
                self.font = font;
                break;
            }
            case GroupNameLabel:{
                self.textColor = [UIColor colorWithRed:0.322 green:0.325 blue:0.333 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.font = font;
                break;
            }
            case SelectPeopleHeader:{
                self.textColor = [UIColor whiteColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20.0f];
                self.font = font;
                break;
            }
            case BlueTitle:{
                self.textColor = [UIColor colorWithRed:0.282 green:0.549 blue:0.898 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:13.0f];
                self.font = font;
                break;
            }
            case ComadCellTitle:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
                self.font = font;
                break;
            }
            case GrayLabel:{
                self.textColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f];
                self.font = font;
                break;
            }
            case ComadId:{
                self.textColor = [UIColor colorWithRed:0.455 green:0.686 blue:0.937 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:10.0f];
                self.font = font;
                break;
            }
            case AddComadLabel:{
                self.textColor = [UIColor blackColor];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
                self.font = font;
                break;
            }
            case TimeAndLocationLabel:{
                self.textColor = [UIColor colorWithRed:0.608 green:0.616 blue:0.627 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11.0f];
                self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
                self.font = font;
                break;
            }
            case NoConversationText:{
                self.textColor = [UIColor colorWithRed:0.800 green:0.792 blue:0.776 alpha:1.0];
                UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0f];
                self.backgroundColor = [UIColor whiteColor];
                self.font = font;
                break;
            }
            default:
                break;
        }
    }
    return self;
}

@end
