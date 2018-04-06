//
//  NetworkManager.m
//  CarnegieProject
//
//  Created by shashank thummalapalli on 4/2/18.
//  Copyright © 2018 shashank thummalapalli. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)fetchDataWithURL:(NSString *)url toDirectory:(NSString *)directory chunkSize:(NSInteger)size chunks:(NSInteger)chunks onCompletion :(CompletionHandler)completionHandler {
    NSInteger initialSize = 0;
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    NSURL *fetchurl = [NSURL URLWithString:url];
    __block NSError *downloadError = nil;
    __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < chunks; i++) {
        NSInteger start = initialSize + 1;
        NSInteger end = initialSize + size;
        NSString *range = [NSString stringWithFormat:@"%ld-%ld", start, end];
        
        dispatch_group_enter(serviceGroup);
        
        [self fetchDataWithURL:fetchurl WithRange:range completion:^(NSData *data, NSError *error) {
            if (!error && data) {
                [weakSelf saveDataToDisk:data range: range directory: directory];
            } else {
                downloadError = error;
            }
            dispatch_group_leave(serviceGroup);
        }];
        initialSize = initialSize + size;
    }
    
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(), ^{
        if (completionHandler) {
            completionHandler(downloadError);
        }
    });
}

// This method downloads the file with specified range
- (void)fetchDataWithURL:(NSURL *)url WithRange:(NSString *)range completion:(void (^)(NSData *data, NSError * error))completionHandler {
    NSMutableURLRequest *fetchRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *rangeValue = [NSString stringWithFormat:@"bytes=%@",range];
    [fetchRequest setValue:rangeValue forHTTPHeaderField:@"range"];
    
    NSURLSessionTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:fetchRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completionHandler != nil) {
            completionHandler(data, error);
        }
    }];
    
    [sessionTask resume];
}

- (void)saveDataToDisk:(NSData *)data range:(NSString *)range directory:(NSString *)dirName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directoryName = dirName.length > 0 ? dirName : @"Default";
    NSString *outputDirectory = [paths[0] stringByAppendingPathComponent:directoryName];
    [[NSFileManager defaultManager] createDirectoryAtPath:outputDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [outputDirectory stringByAppendingPathComponent:range];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"%@",filePath);
}

@end
