//
//  WelcomeViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/9/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SwipeViewController.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *credentialsErrorLabel;


@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [User new];

    // Do any additional setup after loading the view.
}

- (IBAction)onSignInButtonTapped:(id)sender {

    [self loginWithEmail:self.emailTextField.text withPassword:self.passwordTextField.text andSender:sender];
}


- (IBAction)onNeedAccountButtonTapped:(id)sender {
}

-(void)loginWithEmail:(NSString *)email withPassword:(NSString *)password andSender:(id)sender{


    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/tokens"]];

    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];

    // Convert your data and set your request's HTTPBody property
    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:email, @"email", password, @"password", nil];

    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [request setHTTPBody:postdata];


    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //
    //    [NSURLSession sharedSession];

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
                    //                    NSLog(@"%@", text);

                    //                    NSLog(@"data --> %@", data);

                    NSMutableDictionary *tmp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    //                    NSLog(@"temp --> %@", tmp);
                    self.user.token = [tmp objectForKey:@"authentication_token"];

                                        NSLog(@"self.user.token --> %@", self.user.token);

                    [self performSegueWithIdentifier: @"SignInSegue" sender:self];

//                    NSString * storyboardName = @"Main";
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//                    SwipeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
//                    vc.user = self.user;

                    //instead of this use a segue to a nav controller and tap into the nav controller's first viewcontroller property

//                    [self presentViewController:vc animated:YES completion:nil];

                    //set u
                });

            } else {
                NSLog(@"shit didn't work");
                // HANDLE BAD RESPONSE //
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
        // 4
        
    }];
    [postDataTask resume];
    
}

-(void)parseLoginData{
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual: @"SignInSegue"]) {
        UINavigationController *mainNavigationController = segue.destinationViewController;
        SwipeViewController *slvc = [mainNavigationController.childViewControllers objectAtIndex:0];
        
        slvc.user.token = self.user.token;
    }
    
    
}

@end
