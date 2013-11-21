//
//  SelectPeopleTableCell.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/21.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "SelectPeopleTableCell.h"
#import "Image.h"
#import "BasicLabel.h"

@implementation SelectPeopleTableCell
@synthesize userInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, windowSize.size.width, 64);
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.highlighted = YES;
    }
    return self;
}

- (void)setImageAndName {
    UIImage *thumbnailImage = [UIImage imageNamed: [userInfo objectForKey:@"image_name"]];
    UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:64 resizeHeight:64];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImageResize];
    thumbnail.frame = CGRectMake(64, 0, 64, 64);
    [self addSubview:thumbnail];
    
    BasicLabel *nameText = [[BasicLabel alloc]initWithName:FriendCellName];
    nameText.text = [userInfo objectForKey:@"name"];
    [nameText sizeToFit];
    nameText.frame = CGRectMake(130, (64 - nameText.frame.size.height)/2, nameText.frame.size.width, nameText.frame.size.height);
    [self addSubview: nameText];
}

@end
