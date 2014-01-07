//
//  EditProfileViewController+View.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/04.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "EditProfileViewController.h"
#import "BasicLabel.h"
#import "Image.h"
#import "EditThumbnailMask.h"
#import "Configuration.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "Basic.h"

@implementation EditProfileViewController (View) 

-(void)configure {
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    editProfileTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, 495) style:UITableViewStylePlain];
    if((int)iOSVersion == 7){
        editProfileTable.frame = CGRectMake(0, 77, windowSize.size.width, windowSize.size.height - 65);
        editProfileTable.contentSize = CGSizeMake(windowSize.size.width, 1000);
    }else if((int)iOSVersion == 6){
        editProfileTable.frame = CGRectMake(0, 48, windowSize.size.width, windowSize.size.height - 65);
        editProfileTable.contentSize = CGSizeMake(windowSize.size.width, 1000);
    }
    [self.view addSubview: editProfileTable];
    editProfileTable.delegate = self;
    editProfileTable.dataSource = self;
}

//セルの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//ヘッダーの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 100;
            break;
        case 1:
            return 70;
            break;
        case 2:
            return 70;
            break;
        default:
            break;
    }
    return 70;
}

//フッターの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 2){
        return 40;
    }else {
        return 0;
    }
}

//Rowの数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 3;
    }else if(section == 1){
        return 1;
    }
    return 1;
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 3;
}

//ヘッダーの内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    switch (section) {
        case 0:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 100);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            UIImage *thumbnailImage;
            if(profileImage){                
                thumbnailImage = profileImage;
            }else{
                NSString *imageUrl = [NSString stringWithFormat:@"%@/images/profile/%@",HOST_URL, [[Configuration user] objectForKey:@"image_name"]];
                thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
            }
            UIImageView *thumbnail = [[UIImageView alloc]initWithImage: thumbnailImage];
            thumbnail.frame = CGRectMake(20, (header.frame.size.height - 80)/2, 80, 80);
            EditThumbnailMask *mask = [[EditThumbnailMask alloc]init];
            mask.frame = CGRectMake(0, (thumbnail.frame.size.height - 20), 80, 20);
            
            BasicLabel *maskLabel = [[BasicLabel alloc]initWithName:EditThumbnailMaskLabel];
            maskLabel.text = @"編集";
            [maskLabel sizeToFit];
            maskLabel.frame = CGRectMake((80 - maskLabel.frame.size.width)/2, 63, maskLabel.frame.size.width, maskLabel.frame.size.height);
            
            [thumbnail addSubview:mask];
            [thumbnail addSubview:maskLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
            [thumbnail setUserInteractionEnabled:YES];
            [thumbnail addGestureRecognizer:tap];
            [header addSubview:thumbnail];
            break;
        }
        case 1:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:EditProfileHeaderTitle];
            headerLabel.text = @"ひとこと";
            [headerLabel sizeToFit];
            headerLabel.frame = CGRectMake(10, header.frame.size.height - 20, headerLabel.frame.size.width, headerLabel.frame.size.height);
            [header addSubview:headerLabel];
            break;
        }
        case 2:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:EditProfileHeaderTitle];
            headerLabel.text = @"所属";
            [headerLabel sizeToFit];
            headerLabel.frame = CGRectMake(10, header.frame.size.height - 20, headerLabel.frame.size.width, headerLabel.frame.size.height);
            [header addSubview:headerLabel];
            break;
        }
        default:
            break;
    }
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.size.width, 50)];
    footerView.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
    return footerView;
}
 
//セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"a"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"名前";
                    cell.detailTextLabel.text = self.userName;
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"コマドID";
                    cell.detailTextLabel.text = self.comadId;
                    break;
                }
                case 2: {
                    cell.textLabel.text = @"職業";
                    cell.detailTextLabel.text = self.occupation;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1: {
            cell.detailTextLabel.text = self.detail;
            break;
        }
        case 2: {
            cell.detailTextLabel.text = self.question1;
            break;
        }
        default: {
            switch (indexPath.row) {
                case 0: {
                    cell.detailTextLabel.text = @"タップで編集";
                    break;
                }
                default:
                    break;
            }
            break;
        }
    }
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset =  editProfileTable.contentOffset;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    if((int)iOSVersion == 6){
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.title = @"選択してください。";
        [as addButtonWithTitle:@"アルバムから選ぶ"];
        [as addButtonWithTitle:@"キャンセル"];
        as.cancelButtonIndex = 3;
        as.delegate = self;
        
        [as showInView:self.view];
    }else if((int)iOSVersion == 7){
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.title = @"選択してください。";
        [as addButtonWithTitle:@"アルバムから選ぶ"];
        [as addButtonWithTitle:@"キャンセル"];
        as.cancelButtonIndex = 1;
        as.delegate = self;
        
        [as showInView: self.view.window];
    }
}

//アルバムを開く
-(void)doAlbum {
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    
    [self presentModalViewController:picker animated:YES];
}

#pragma UIImagePickerController Delegate methods
//画像が選択された時に呼ばれる。
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *path = [info objectForKey: UIImagePickerControllerReferenceURL];
    //画像をチェンジ
    profileImage = image;
    imagePath = path;
      NSLog(@"%@", path);
    
    [self dismissModalViewControllerAnimated:YES];
    [editProfileTable reloadData];
}

// 選択がキャンセルされた時に呼ばれる。
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES]; // モーダルビューを閉じる
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            //アルバムから選択
            [self doAlbum];
        }
        default:
            break;
    }
}

@end
