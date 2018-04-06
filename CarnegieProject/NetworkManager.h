//
//  NetworkManager.h
//  CarnegieProject
//
//  Created by shashank thummalapalli on 4/2/18.
//  Copyright © 2018 shashank thummalapalli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSError *error);

@interface NetworkManager : NSObject

/*
 @discussion This method downloads the file for URL with specified chunk size and the number of chunks
             and writes the data to the output directory in documents.
 @param url       The URL of the file to download.
 @param directory Creates a directory inside the documents directory.
 @param size      The size of the chunk in bytes.
 @param chunks    The numbers of chunks of the specified size to be downloaded.
 @param completionHandler A block to execute when the download is complete. Passes the error in the completion handler in case of failures.
 */
- (void)fetchDataWithURL:(NSString *)url toDirectory:(NSString *)directory chunkSize:(NSInteger)size chunks:(NSInteger)chunks onCompletion:(CompletionHandler)completionHandler;

@end
