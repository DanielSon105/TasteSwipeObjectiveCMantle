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
@property NSDictionary *getMealDictionaryJSON;
@property NSMutableArray *arrayOfMeals;
@property NSString *identification;

@end

@implementation SwipeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    NSLog(@"svc viewdidload token --> %@", self.user.token);

    SwipedCardBackgroundView *swipedCardBackground = [[SwipedCardBackgroundView alloc]initWithFrame:self.view.frame];
    [swipedCardBackground getMealInfo:self.user.token];
    [self.view addSubview:swipedCardBackground];

}

- (IBAction)onResetButtonTapped:(id)sender {
//potentially reset so we don't have to restart app when testing
}



@end
