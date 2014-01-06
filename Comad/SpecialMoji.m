//
//  SpecialMoji.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/19.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "SpecialMoji.h"
#import "Image.h"

@implementation SpecialMoji

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        windowSize = [[UIScreen mainScreen] bounds];
        iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height - 230);
        [self setView];
    }
    return self;
}

- (void)setView {
    //scrollView設置
    /*
    UIScrollView *stampMenu = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 15, windowSize.size.width, 50)];
    stampMenu.backgroundColor = [UIColor yellowColor];
    stampMenu.contentSize = CGSizeMake(windowSize.size.width * 2, 50);
    [self addSubview: stampMenu];
    */
    //collectionView設置
    //layout定義
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(78, 78);
    layout.minimumInteritemSpacing = 0.0f;
    layout.minimumLineSpacing = 1.0f;
    
    //UICollectionView
    UICollectionView *stamps = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, windowSize.size.width, windowSize.size.height - 230) collectionViewLayout:layout];
    if((int)iOSVersion == 6){
        stamps.frame = CGRectMake(0, 0, windowSize.size.width, windowSize.size.height - 230);
    }else if((int)iOSVersion == 7){
        stamps.frame = CGRectMake(0, 10, windowSize.size.width, windowSize.size.height - 230);
    }
    stamps.backgroundColor = [UIColor whiteColor];
    stamps.delegate = self;
    stamps.dataSource = self;
    [stamps registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [stamps setCollectionViewLayout: layout];
    [self addSubview: stamps];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Stamp" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *imageName = [dic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];

    UIImage *thumbnailImage = [UIImage imageNamed: imageName];
    UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImage];
    thumbnail.frame = CGRectMake(0, 0, 80, 80);
    [cell.contentView addSubview: thumbnail];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"Stamp" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    return [dic count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate stampClickedDelegate:indexPath.row];
}

@end