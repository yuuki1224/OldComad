//
//  Bubble.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/10.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Bubble.h"
#import "BasicLabel.h"

@implementation Bubble
@synthesize userName, sentence, bubbleHeight, imageName;

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

- (void)drawRect:(CGRect)rect
{
    nameLabel.text = userName;
    [nameLabel sizeToFit];
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm a"];
    timeLabel.text = [formatter stringFromDate:now];
    [timeLabel sizeToFit];
    
    switch (self.side) {
        case Left:
            [self drawLeftBubble];
            break;
        case Right:
            [self drawRightBubble];
            break;
        default:
            break;
    }
}

-(void)drawRightBubble {
    //self.sentenceに入ってる文字を描画する
    CGSize bounds = CGSizeMake(150, 500);
    
    UILineBreakMode mode = UILineBreakModeWordWrap;
    CGSize size = [self.sentence sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:bounds lineBreakMode: mode];
    int rowNum = (int)size.height/14;
    
    float height = size.height + 16;
    self.bubbleHeight = height;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //状態保存
    CGContextSaveGState(context);
    
    //バブルを描く領域
    //ここだけ指定したらいいようにしたい
    CGRect bubbleRect = CGRectMake(windowSize.size.width - 180, 5, 170, height);
    CGContextBubblePathRight(context, bubbleRect);
    CGContextBubblePathRight(context, bubbleRect);
    CGPathRef bubblePath = CGContextCopyPath(context);
    
    //影
    CGContextSetShadow(context,CGSizeMake(0,1), 3);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillPath(context);
    CGContextSetShadow(context,CGSizeZero,0);
    
    //背景
    CGContextAddPath(context, bubblePath);
    CGContextClip(context);
    CGFloat locations[] = {0.0, 0.2, 0.8, 1.0};
    CGFloat components[] = {
        0.506,0.722,0.990,1.0,
        0.652,0.849,0.996,1.0,
        0.652,0.849,0.996,1.0,
        0.803,0.945,1.000,1.0
    };
    size_t count = sizeof(components) / (sizeof(CGFloat)*4);
    CGPoint startPoint = bubbleRect.origin;
    CGPoint endPoint = startPoint;
    endPoint.y += bubbleRect.size.height;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
    
    //縁取り
    CGContextAddPath(context, bubblePath);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.3);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    //Path解放
    CGPathRelease(bubblePath);
    
    //保存してた状態に戻す
    CGContextRestoreGState(context);
    
    //テキストの描画領域指定
    //CGRect textRect = CGRectMake(windowSize.size.width - 225, 25, 150, 60);
    CGRect textRect = CGRectMake(bubbleRect.origin.x + 10 , bubbleRect.origin.y + 8, bubbleRect.size.width - 23 , bubbleRect.size.height - 16);
    
    //NSString *text = @"こんにちは。\n吹き出し描いたよ。\nくちばし部分の構造は下の絵を見てね。";
    NSString *text = self.sentence;
    [[UIColor colorWithWhite:0.1 alpha:1] set];
    [text drawInRect:textRect withFont:[UIFont systemFontOfSize:12]];
    
    timeLabel.frame = CGRectMake(bubbleRect.origin.x - timeLabel.frame.size.width - 7 , bubbleRect.origin.y + bubbleRect.size.height - 10, timeLabel.frame.size.width, timeLabel.frame.size.height);
    [self addSubview:timeLabel];
     
}

-(void)drawLeftBubble {
    CGSize bounds = CGSizeMake(150, 500);
    
    UILineBreakMode mode = UILineBreakModeWordWrap;
    CGSize size = [self.sentence sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:bounds lineBreakMode: mode];
    int rowNum = (int)size.height/14;
    
    float height = size.height + 16;
    self.bubbleHeight = height;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //状態保存
    CGContextSaveGState(context);
    
    //バブルを描く領域
    CGRect bubbleRect = CGRectMake(65, 10, 170, height);
    CGContextBubblePath(context, bubbleRect);
    CGContextBubblePath(context, bubbleRect);
    CGPathRef bubblePath = CGContextCopyPath(context);

    //影
    CGContextSetShadow(context,CGSizeMake(0,1), 3);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillPath(context);
    CGContextSetShadow(context,CGSizeZero,0);
    
    //背景
    CGContextAddPath(context, bubblePath);
    CGContextClip(context);
    CGFloat locations[] = {0.0, 0.2, 0.8, 1.0};
    CGFloat components[] = {
        0.506,0.722,0.990,1.0,
        0.652,0.849,0.996,1.0,
        0.652,0.849,0.996,1.0,
        0.803,0.945,1.000,1.0
    };
    size_t count = sizeof(components) / (sizeof(CGFloat)*4);
    CGPoint startPoint = bubbleRect.origin;
    CGPoint endPoint = startPoint;
    endPoint.y += bubbleRect.size.height;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
    
    //縁取り
    CGContextAddPath(context, bubblePath);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.3);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    //Path解放
    CGPathRelease(bubblePath);
    
    //保存してた状態に戻す
    CGContextRestoreGState(context);
    
    //テキスト
    CGRect textRect = CGRectMake(bubbleRect.origin.x + 18, bubbleRect.origin.y + 8, bubbleRect.size.width - 25 , bubbleRect.size.height - 16);;
    NSString *text = self.sentence;
    [[UIColor colorWithWhite:0.1 alpha:1] set];
    [text drawInRect:textRect withFont:[UIFont systemFontOfSize:12]];
    
    //---------
    // 顔Icon
    
    //状態保存
    CGContextSaveGState(context);
    
    //Path作成
    CGRect profRect = CGRectMake(15, bubbleRect.origin.y + bubbleRect.size.height - 20, 40, 40);
    CGContextRoundRectPath(context, profRect, 4.0);
    CGPathRef profPath = CGContextCopyPath(context);
    
    //画像描画
    CGContextClip(context);
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL, imageName];
    NSData *urlImage = [NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    UIImage *profImage = [[UIImage alloc] initWithData: urlImage];
    [profImage drawInRect: profRect];
    
    //縁取り
    CGContextAddPath(context, profPath);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.3);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    //Path解放
    CGPathRelease(profPath);
    
    //保存してた状態に戻す
    CGContextRestoreGState(context);
    
    nameLabel.frame = CGRectMake(10, bubbleRect.origin.y + bubbleRect.size.height + 22, nameLabel.frame.size.width, nameLabel.frame.size.height);
    timeLabel.frame = CGRectMake(bubbleRect.origin.x + bubbleRect.size.width + 10, bubbleRect.origin.y + bubbleRect.size.height - 10, timeLabel.frame.size.width, timeLabel.frame.size.height);
    [self addSubview:nameLabel];
    [self addSubview:timeLabel];
}

//角度→ラジアン変換
#if !defined(RADIANS)
#define RADIANS(D) (D * M_PI / 180)
#endif

//左に吹き出し
void CGContextBubblePath(CGContextRef context, CGRect rect)
{
    CGFloat rad = 10;  //角の半径
    CGFloat qx = 10; // くちばしの長さ
    CGFloat qy = 20; // くちばしの高さ
    CGFloat cqy = 4; // 上くちばしカーブの基準点の高さ
    CGFloat lx = CGRectGetMinX(rect)+qx; //左
    CGFloat rx = CGRectGetMaxX(rect); //右
    CGFloat ty = CGRectGetMinY(rect); //上
    CGFloat by = CGRectGetMaxY(rect); //下
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, lx, ty+rad); //左上
    CGContextAddArc(context, lx+rad, ty+rad, rad, RADIANS(180), RADIANS(270), 0); //左上のカーブ
    CGContextAddArc(context, rx-rad, ty+rad, rad, RADIANS(270), RADIANS(360), 0); //右上のカーブ
    CGContextAddArc(context, rx-rad, by-rad, rad, RADIANS(0), RADIANS(90), 0); //右下のカーブ
    CGContextAddArc(context, lx+rad, by-rad, rad, RADIANS(90), RADIANS(125), 0); //くちばしの付け根(下の凹み)
    CGContextAddQuadCurveToPoint(context, lx, by, lx-qx, by); //くちばしの先端
    CGContextAddQuadCurveToPoint(context, lx, by-cqy, lx, by-qy); //くちばしの付け根(上)
    
    CGContextClosePath(context); //左上の点まで閉じる
}

// 右に吹き出し
void CGContextBubblePathRight(CGContextRef context, CGRect rect) {
    CGFloat rad = 10;  //角の半径
    CGFloat qx = 10; // くちばしの長さ
    CGFloat qy = 20; // くちばしの高さ
    CGFloat cqy = 4; // 上くちばしカーブの基準点の高さ
    CGFloat lx = CGRectGetMinX(rect); //左
    CGFloat rx = CGRectGetMaxX(rect)-qx; //右
    CGFloat ty = CGRectGetMinY(rect); //上
    CGFloat by = CGRectGetMaxY(rect); //下
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, rx, ty+rad); //右上
    CGContextAddArc(context, rx-rad, ty+rad, rad, RADIANS(360), RADIANS(270), 1); //右上のカーブ
    CGContextAddArc(context, lx+rad, ty+rad, rad, RADIANS(270), RADIANS(180), 1); //左上のカーブ
    CGContextAddArc(context, lx+rad, by-rad, rad, RADIANS(180), RADIANS(90), 1); //左下のカーブ
    CGContextAddArc(context, rx-rad, by-rad, rad, RADIANS(90), RADIANS(55), 1); //くちばしの付け根(下の凹み)
    
    CGContextAddQuadCurveToPoint(context, rx, by, rx+qx, by); //くちばしの先端
    CGContextAddQuadCurveToPoint(context, rx, by-cqy, rx, by-qy); //くちばしの付け根(上)
    
    CGContextClosePath(context); //左上の点まで閉じる

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

- (void)setLabel {
    nameLabel.text = self.userName;
}
@end
