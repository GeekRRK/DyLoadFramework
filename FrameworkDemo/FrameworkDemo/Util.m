//
//  Util.m
//  FrameworkDemo
//
//  Created by GeekRRK on 15/5/8.
//  Copyright (c) 2015年 GeekRRK. All rights reserved.
//

#import "Util.h"
#import "zip.h"
#import "ZipArchive.h"

@implementation Util

//下载并解压缩
+ (NSInteger) downloadFile:(NSString *)urlAsString asFileName:(NSString *)fileName{
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request  returningResponse:nil  error:&error];
    
    if(data == nil){
        return -1;
    }
    
    if (data != nil){
        NSLog(@"下载成功");
        NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        if(!docDir) {
            NSLog(@"Documents 目录未找到");
        }
        NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
        
        if([data writeToFile:filePath atomically:YES]){
            NSLog(@"保存成功.");
        }else
        {
            NSLog(@"保存失败.");
        }
    } else {
        NSLog(@"%@", error);
    }
    
    [self unzip:fileName];
    
    //0下载成功
    return 0;
}

//解压缩zip文件
+ (BOOL)unzip:(NSString *)fileName{
    ZipArchive* zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if(!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    
    NSString *from = [docDir stringByAppendingPathComponent:fileName];
    NSRange range = [fileName rangeOfString:@".zip"];
    NSString *to = [docDir stringByAppendingPathComponent:[fileName substringToIndex:range.location]];
    if([zip UnzipOpenFile:from])
    {
        BOOL ret = [zip UnzipFileTo:to overWrite:YES];
        if(NO == ret)
        {
        }
        [zip UnzipCloseFile];
        return YES;
    }
    return NO;
}

@end
