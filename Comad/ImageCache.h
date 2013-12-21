//
//  ImageCache.h
//  Comad
//
//  Created by 浅野 友希 on 2013/12/18.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImageCacheResultBlock)(UIImage *image, NSError *error);

@interface ImageCache : NSObject
+ (ImageCache *)sharedInstance;
- (UIImage *)imageWithURL:(NSString *)URL
                    block:(ImageCacheResultBlock)block;
- (UIImage *)imageWithURL:(NSString *)URL
             defaultImage:(UIImage *)defaultImage
                    block:(ImageCacheResultBlock)block;
- (void)clearMemoryCache;
- (void)deleteAllCacheFiles;

@end
