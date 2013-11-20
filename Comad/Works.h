//
//  Works.h
//  Comad
//
//  Created by 浅野 友希 on 2013/10/13.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComadsDelegate;

@interface Works : UITableView <UITableViewDataSource> {
    NSMutableArray *_willComads;
    NSMutableArray *_groupComad;
    NSMutableArray *_comads;
}

@property (nonatomic, assign) id<ComadsDelegate> hoge;

@end

@protocol ComadsDelegate <NSObject>
-(void)showComad;
@end
