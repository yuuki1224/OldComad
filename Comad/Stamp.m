//
//  Stamp.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/22.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Stamp.h"
#import "Image.h"

@implementation Stamp
@synthesize side, userName, imageName;

- (id)initWithName:(Side)name {
    self = [super init];
    if(self){
        windowSize = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor whiteColor];
        self.side = name;
        nameLabel = [[BasicLabel alloc]initWithName: ConversationName];
        timeLabel = [[BasicLabel alloc]initWithName: ConversationTime];
    }
    return self;
}

- (void)setStamp:(NSString *)stampName conversationHeight:(int)conversationHeight {
    if(self.side == Right){
        self.frame = CGRectMake(0, conversationHeight, windowSize.size.width, 120);
        
        UIImage *stampImage = [UIImage imageNamed: stampName];
        UIImageView *stampView = [[UIImageView alloc]initWithImage: stampImage];
        stampView.frame = CGRectMake(windowSize.size.width - 135, 0, 120, 120);
        [self addSubview: stampView];
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        timeLabel.text = [formatter stringFromDate:now];
        [timeLabel sizeToFit];
        timeLabel.frame = CGRectMake(stampView.frame.origin.x - timeLabel.frame.size.width - 10, stampView.frame.size.height - timeLabel.frame.size.height, timeLabel.frame.size.width, timeLabel.frame.size.height);
        [self addSubview: timeLabel];
    }else if(self.side == Left){
        self.frame = CGRectMake(0, conversationHeight, windowSize.size.width, 120);
        
        UIImage *stampImage = [UIImage imageNamed: stampName];
        UIImageView *stampView = [[UIImageView alloc]initWithImage: stampImage];
        stampView.frame = CGRectMake(77, 0, 120, 120);
        [self addSubview: stampView];
        
        nameLabel.text = userName;
        [nameLabel sizeToFit];
        nameLabel.frame = CGRectMake(15, 50, nameLabel.frame.size.width, nameLabel.frame.size.height);
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        timeLabel.text = [formatter stringFromDate:now];
        [timeLabel sizeToFit];
        timeLabel.frame = CGRectMake(180, stampView.frame.size.height - timeLabel.frame.size.height, timeLabel.frame.size.width, timeLabel.frame.size.height);
        [self addSubview:nameLabel];
        [self addSubview:timeLabel];
        
        UIImage *thumbnailImage = [UIImage imageNamed: imageName];
        UIImageView *thumbnail = [[UIImageView alloc]initWithImage: thumbnailImage];
        thumbnail.frame = CGRectMake(18, 65, 40, 40);
        [self addSubview:thumbnail];
    }
}
/*
//角度→ラジアン変換
#if !defined(RADIANS)
#define RADIANS(D) (D * M_PI / 180)
#endif

- (void)drawImage {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //---------
    // 顔Icon
    
    //状態保存
    //CGContextSaveGState(context);
    
    //Path作成
    CGRect profRect = CGRectMake(15, 50, 40, 40);
    CGContextRoundRectPath(context, profRect, 4.0);
    CGPathRef profPath = CGContextCopyPath(context);
    
    //画像描画
    CGContextClip(context);
    UIImage *profImage = [UIImage imageNamed: self.userName];
    [profImage drawInRect: profRect];
    
    //縁取り
    CGContextAddPath(context, profPath);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.3);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    //Path解放
    CGPathRelease(profPath);
    
    //保存してた状態に戻す
    //CGContextRestoreGState(context);
}

//角丸の図形を描く
void CGContextRoundRectPath(CGContextRef context, CGRect rect, CGFloat radius)
{
    CGFloat lx = CGRectGetMinX(rect);
    CGFloat rx = CGRectGetMaxX(rect);
    CGFloat ty = CGRectGetMinY(rect);
    CGFloat by = CGRectGetMaxY(rect);
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, lx+radius, by);
    CGContextAddArcToPoint(context, lx, by, lx, by-radius, radius);
    CGContextAddArcToPoint(context, lx, ty, lx+radius, ty, radius);
    CGContextAddArcToPoint(context, rx, ty, rx, ty+radius, radius);
    CGContextAddArcToPoint(context, rx, by, rx-radius, by, radius);
    
    CGContextClosePath(context);
}
*/
@end
