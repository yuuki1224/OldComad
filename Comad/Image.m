//
//  Image.m
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "Image.h"
#import <QuartzCore/QuartzCore.h>

@implementation Image

- (id)init {
    self = [super init];
    if (self != nil) {
        largeFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:20.0f];
        middleFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:20.0f];
        smallFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:20.0f];
    }
    return self;
}

+(UIImage *) resizeImage:(UIImage *)original resizePer:(float)per {
    CGSize sz = CGSizeMake(original.size.width*per,
                           original.size.height*per);
    UIGraphicsBeginImageContext(sz);
    [original drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
}

+(UIImage *) resizeImage:(UIImage *)original resizeWidth:(float)resizeWidth resizeHeight:(float)resizeHeight {
    CGSize sz = CGSizeMake(resizeWidth, resizeHeight);
    UIGraphicsBeginImageContext(sz);
    [original drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
}

+ (UIImage *)makeCornerRoundImage:(UIImage *) image {
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, 200, 200);
    imageLayer.contents = (id) image.CGImage;
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = 100.0f;
    
    UIGraphicsBeginImageContext(imageLayer.frame.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundedImage;
}

@end
