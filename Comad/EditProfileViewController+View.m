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

@implementation EditProfileViewController (View) 

-(void)configure {
    iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    editProfileTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 77, windowSize.size.width, 495) style:UITableViewStylePlain];
    if((int)iOSVersion == 7){
        editProfileTable.frame = CGRectMake(0, 77, windowSize.size.width, 495);
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
            UIImage *thumbnailImage = [UIImage imageNamed:@"asano.png"];
            UIImage *thumbnailImageResize = [Image resizeImage:thumbnailImage resizeWidth:80 resizeHeight:80];
            UIImageView *thumbnail = [[UIImageView alloc]initWithImage:thumbnailImageResize];
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
        case 3:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:EditProfileHeaderTitle];
            headerLabel.text = @"好きな言語は?";
            [headerLabel sizeToFit];
            headerLabel.frame = CGRectMake(10, header.frame.size.height - 20, headerLabel.frame.size.width, headerLabel.frame.size.height);
            [header addSubview:headerLabel];
            break;
        }
        case 4:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:EditProfileHeaderTitle];
            headerLabel.text = @"使えるAdobe製品は?";
            [headerLabel sizeToFit];
            headerLabel.frame = CGRectMake(10, header.frame.size.height - 20, headerLabel.frame.size.width, headerLabel.frame.size.height);
            [header addSubview:headerLabel];
            break;
        }
        case 5:{
            header.frame = CGRectMake(0, 0, windowSize.size.width, 70);
            header.backgroundColor = [UIColor colorWithRed:0.902 green:0.890 blue:0.875 alpha:1.0];
            BasicLabel *headerLabel = [[BasicLabel alloc]initWithName:EditProfileHeaderTitle];
            headerLabel.text = @"好きなエディターは?";
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
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = self.detail;
                    break;
                default:
                    break;
            }
            break;
        }
        case 2: {
            cell.detailTextLabel.text = self.question1;
            break;
        }
        case 3: {
            cell.detailTextLabel.text = self.question2;
            break;
        }
        case 4: {
            cell.detailTextLabel.text = self.question3;
            break;
        }
        case 5: {
            cell.detailTextLabel.text = self.question4;
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
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.title = @"選択してください。";
    [as addButtonWithTitle:@"カメラでとる"];
    [as addButtonWithTitle:@"アルバムから選ぶ"];
    [as addButtonWithTitle:@"写真を削除する"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 3;
    as.delegate = self;
    
    [as showInView:self.view];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            //カメラ起動
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                /*
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
                // カメラかライブラリからの読込指定。カメラを指定。
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                // トリミングなどを行うか否か
                [imagePickerController setAllowsEditing:YES];
                // Delegate
                [imagePickerController setDelegate:self];
                
                // アニメーションをしてカメラUIを起動
                [self presentViewController:imagePickerController animated:YES completion:nil];
                 */
            }
            else
            {
            }
            break;
        }
        case 1: {
            //アルバムから選択
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                /*
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imagePickerController setAllowsEditing:YES];
                [imagePickerController setDelegate:self];
                
                //[self presentViewController:imagePickerController animated:YES completion:nil];
                // iPadの場合はUIPopoverControllerを使う
                popover = [[UIPopoverController alloc]initWithContentViewController:imagePickerController];
                //[popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                 */
            }
            else
            {
            }
            break;
        }
        case 2: {
            //写真を削除　→アラート出るように
            break;
        }
        default:
            break;
    }
}

@end
