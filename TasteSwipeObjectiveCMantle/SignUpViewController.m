//
//  SignUpViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/9/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SignUpViewController.h"
//#import "SuccessfulLoginViewController.h"

@interface SignUpViewController () <UIGestureRecognizerDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (IBAction)onSignUpButtonTapped:(id)sender {
    [self postSignUpWithEmail:self.emailTextField.text withPassword:self.passwordTextField.text withPasswordConfirmation:self.passwordConfirmationTextField.text];

}


-(void)postSignUpWithEmail:(NSString *)email withPassword:(NSString *)password withPasswordConfirmation:(NSString *)passwordConfirmation{

    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/registration"]];

    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // Set Header Fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];

    // Convert data and set request's HTTPBody property
    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:email, @"email", password, @"password", passwordConfirmation, @"password_confirmation", nil];

    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [request setHTTPBody:postdata];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        //do stuff

        //IF e-mail has been taken --> populate error label "email has been taken"

        //IF password is too short --> populate error label "password is too short"

        //IF passwords don't match --> populate error label "passwords don't match"

        //ELSE return token  --> set user.token = returnedTokenString


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


                    //set u
                });

            } else {
                NSLog(@"Sign-up didn't work");
                // HANDLE BAD RESPONSE //
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
        // 4
        
    }];
    [postDataTask resume];
    
}





@end
