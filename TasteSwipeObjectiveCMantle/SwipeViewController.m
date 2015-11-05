//
//  SwipeViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//
#import "SwipeViewController.h"
#import "SwipedCardBackgroundView.h"
#import "Meal.h"

@interface SwipeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property NSDictionary *getMealDictionaryJSON;
@property NSMutableArray *arrayOfMeals;
@property NSString *identification;

@property Meal *meal1;
@property Meal *meal2;
@property Meal *meal3;
@property Meal *meal4;
@property Meal *meal5;

@end

@implementation SwipeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self getMealInfo];

    //LOAD MEALS HERE... for now we'll load up 5 random ones... we need to write algorithm after though
    //
    SwipedCardBackgroundView *swipedCardBackground = [[SwipedCardBackgroundView alloc]initWithFrame:self.view.frame];
    [swipedCardBackground changeMeMethod];
    [self.view addSubview:swipedCardBackground];
    // Do any additional setup after loading the view.
}

- (IBAction)onResetButtonTapped:(id)sender {
//potentially reset so we don't have to restart app when testing
}

#pragma mark - Post Right Methods

-(void)loadJSONMealData{

}

-(void)postRight{
    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];

    NSString *base_url = @"http://tasteswipe-int.herokuapp.com";
    NSString *identification = self.identification;
    NSString *path =@"/meal/";
    NSString *after_id = @"/right";


    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",base_url,path,identification,after_id]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/meal/2/right"]];


    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];


    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {



        //do stuff

    }];
    [postDataTask resume];
    
}


-(void)getMealInfo
{

    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:
     @{@"Accept": @"application/json", @"Content-Type": @"application/json"}];

    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate:self
                             delegateQueue:nil];

    NSURL *url =[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/meal"];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error != nil) {
            NSLog(@"---> ERROR :: %@", error);
        }

        dispatch_async(dispatch_get_main_queue(), ^{

            self.getMealDictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];


            self.arrayOfMeals = [NSMutableArray new];
            NSLog(@"getMealDictionaryJSON %@", self.getMealDictionaryJSON);

            Meal *meal = [[Meal alloc] initMealWithContentsOfDictionary:self.getMealDictionaryJSON];

//            self.meal1 = meal;
//            self.meal2 = meal;
//            self.meal3 = meal;
//            self.meal4 = meal;
//            self.meal5 = meal;

            [self.arrayOfMeals addObject:meal];

            NSLog(@"%@", self.arrayOfMeals);
            for (Meal *temp in self.arrayOfMeals) {
                NSLog(@"%@", temp.mealName);

            }
        });
    }];
    
    [task resume];
    
}









/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
