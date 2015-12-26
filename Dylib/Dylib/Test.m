//
//  Test.m
//  Dylib
//
//  Created by GeekRRK on 15/3/25.
//  Copyright (c) 2015年 GeekRRK. All rights reserved.
//

#import "Test.h"

@interface Test ()

@end

#define cSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define cSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation Test

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    float btnW = cSCREENWIDTH / 3;
    float btnH = cSCREENHEIGHT / 4;
    float btnX = (cSCREENWIDTH - btnW) / 2;
    float btnY = (cSCREENHEIGHT / 2 - btnH) / 2;
    CGRect frame = CGRectMake(btnX, btnY, btnW, btnH);
    UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    someAddButton.backgroundColor = [UIColor clearColor];
    [someAddButton setTitle:@"点击2" forState:UIControlStateNormal];
    someAddButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    someAddButton.frame = frame;
    [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    float imgW = cSCREENWIDTH;
    float imgH = cSCREENHEIGHT / 2.2;
    float imgX = (cSCREENWIDTH - imgW) / 2;
    float imgY = CGRectGetMaxY(someAddButton.frame) + 20;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Dylib.framework/img.jpg"];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
    
    [self.view addSubview:imgView];
    [self.view addSubview:someAddButton];
}

-(void) someButtonClicked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"点击事件2！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
