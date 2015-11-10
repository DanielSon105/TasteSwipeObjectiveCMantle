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

    SwipedCardBackgroundView *swipedCardBackground = [[SwipedCardBackgroundView alloc]initWithFrame:self.view.frame];
    [swipedCardBackground changeMeMethod];
    [self.view addSubview:swipedCardBackground];
    // Do any additional setup after loading the view.
}

- (IBAction)onResetButtonTapped:(id)sender {
//potentially reset so we don't have to restart app when testing
}



@end
