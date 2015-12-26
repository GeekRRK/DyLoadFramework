//
//  ViewController.m
//  FrameworkDemo
//
//  Created by GeekRRK on 15/3/25.
//  Copyright (c) 2015年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import "Util.h"

#define DynamicName @"Dylib.framework"
#define FIRSTDYLIBADDR @"https://github.com/GeekRRK/DyLoadFramework/raw/master/Dylib.framework1.zip"
#define SECONDDYLIBADDR @"https://github.com/GeekRRK/DyLoadFramework/raw/master/Dylib.framework2.zip"

@interface ViewController ()

@property(nonatomic,retain) UIScrollView *scroll;
@property(nonatomic,retain) UIButton *btn;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [Util downloadFile:FIRSTDYLIBADDR asFileName:DynamicName@".zip"];
}

void *libHandle;

- (void)dlopenLoadDylibWithPath:(NSString *)path
{
    libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
}

- (IBAction)onDlopenLoadAtPathAction:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/"DynamicName"/Dylib",NSHomeDirectory()];
    [self dlopenLoadDylibWithPath:documentsPath];
}

- (void)bundleLoadDylibWithPath:(NSString *)path
{
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}

- (IBAction)onBundleLoadAtPathAction:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/"DynamicName,NSHomeDirectory()];
    [self bundleLoadDylibWithPath:documentsPath];
}

- (IBAction)onTriggerButtonAction:(id)sender
{
    Class rootClass = NSClassFromString(@"Test");
    if (rootClass) {
        id object = [[rootClass alloc] init];
        [self.navigationController pushViewController:object animated:YES];
    }
}

@end
