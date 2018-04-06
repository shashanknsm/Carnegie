Carnegie coding task
--------------------

This is the coding task for Carnegie Technologies.

This app downloads the file in specified chunk size and writes the file to documents directory.

Run the app in simulator/ device and tap download to start the download the file.

Change the input parameters/ url for the file to download.

````objective-c
    [self.networkManager fetchDataWithURL:@"your url here"
                              toDirectory: @"output directory"
                                chunkSize: 1049000
                                   chunks: 4
                             onCompletion:^(NSError *error) {

    }];
````