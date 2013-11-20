//
//  Image.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/16.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject {
    UIFont *largeFont;
    UIFont *middleFont;
    UIFont *smallFont;
}
+(UIImage *) resizeImage:(UIImage *)original resizePer:(float)per;
+(UIImage *) resizeImage:(UIImage *)original resizeWidth:(float)resizeWidth resizeHeight:(float)resizeHeight;
+ (UIImage *)makeCornerRoundImage:(UIImage *) image;
@end
