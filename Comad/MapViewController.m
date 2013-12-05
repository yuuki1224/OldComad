//
//  MapViewController.m
//  Comad
//
//  Created by 浅野 友希 on 2013/11/02.
//  Copyright (c) 2013年 Yuki Asano. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GoogleMaps.h"
#import "Image.h"
#import "Header.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        Header *header = [[Header alloc]init];
        [header setTitle:@"コマドスポット"];
        
        [self.view addSubview:header];
        [self setBackBtnInHeader];
    }
    return self;
}

- (void)viewDidLoad
{
    [GMSServices provideAPIKey:@"AIzaSyCYwD1MORyY6q2FVOLjHbT4siYpeZxPScQ"];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.029188
                                                            longitude:135.759298
                                                            zoom:14];
    
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"寒梅館";
    marker.map = self.mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    CLLocationCoordinate2D co;
    co.latitude = 35.030453;
    co.longitude = 135.77247;
    marker2.position = co;
    marker2.snippet = @"出町ロッテリア";
    marker2.map = self.mapView;

    
    [self.mapView startRendering];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackBtnInHeader {
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImage *imageResize = [Image resizeImage:image resizePer:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 36, 20, 28);
    [btn setImage:imageResize forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
}

- (void)backBtnClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
