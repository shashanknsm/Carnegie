//
//  ViewController.m
//  CarnegieProject
//
//  Created by shashank thummalapalli on 4/2/18.
//  Copyright © 2018 shashank thummalapalli. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()

@property(nonatomic, strong) NetworkManager *networkManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [NetworkManager new];
}

- (IBAction)download:(id)sender {
    [self.networkManager fetchDataWithURL: @"http://a6cf3ebf.bwtest-aws.pravala.com/384MB.jar"
                              toDirectory: @"CarnegieFile"
                                chunkSize: 1049000
                                   chunks: 4
                             onCompletion:^(NSError *error) {
                                 if (error) {
                                     NSLog(@"Error is %@",[error localizedDescription]);
                                 }
    }];
    
    
}


@end
