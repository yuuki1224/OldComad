//
//  Basic.h
//  Comad
//
//  Created by 浅野 友希 on 2013/11/12.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

//#define HOST_URL @"http://153.121.37.225:3000/"
#define HOST_URL @"http://localhost:3000/"
#define SCREEN_BOUNDS   ([UIScreen mainScreen].bounds)
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#ifndef Comad_Basic_h
#define Comad_Basic_h

typedef enum : NSInteger{
    StartTimeSelected = 0,
    EndTimeSelected
}TimeSelected;

typedef enum : NSInteger{
    WifiSelected = 0,
    PowerSourceSelected
}StatusSelected;

typedef enum : NSInteger{
    IDontKnow = 0,
    Exist,
    Nothing
}Whether;

typedef enum : NSInteger{
    Name = 0,
    ComadID,
    Occupation,
    Detail,
    Question1,
    Question2,
    Question3,
    Question4
}EditProfileCell;

typedef enum : NSInteger{
    Left = 0,
    Right
}Side;

typedef enum : NSInteger{
    PrivateMessage = 0,
    GroupMessage
}MessageType;

#endif
