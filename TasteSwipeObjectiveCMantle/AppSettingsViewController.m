//
//  AppSettingsViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/9/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "AppSettingsViewController.h"

@interface AppSettingsViewController ()

@end

@implementation AppSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onLogoutButtonTapped:(id)sender {
    [self deleteToken:self.user.token];

}


-(void)deleteToken:(NSString *)token
{
    NSLog(@"delete Token ---> %@", token);

    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];


    NSURL *url =[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/tokens"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"DELETE";

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];

    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];

    //    NSLog([NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token]);

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (httpResp.statusCode == 200) {
                    // 3
                    NSString *text =
                    [[NSString alloc]initWithData:data
                                         encoding:NSUTF8StringEncoding];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        NSLog(@"%@", text);
                        NSLog(@"delete works");

                        //set u
                    });

                } else {
                    NSLog(@"shit didn't work");
                    NSLog(@"%ld", (long)httpResp.statusCode);
                    // HANDLE BAD RESPONSE //
                }
            } else {
                // ALWAYS HANDLE ERRORS :-] //
            }

        });
    }];

    
    [task resume];
    
}




@end
