//
//  SwipedCardBackgroundView.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SwipedCardBackgroundView.h"
#import "Meal.h"
#import <UIKit/UIKit.h>

@implementation SwipedCardBackgroundView {

NSInteger cardsLoadedIndex; // the index of the card you have loaded into the loadedCards array last
NSMutableArray *loadedCards; // the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)

NSDictionary *getMealDictionaryJSON;
NSMutableArray *arrayOfMealDictionaries;
NSMutableArray *arrayOfMeals; //

UIButton *menuButton;
UIButton *messageButton;
UIButton *checkButton;
UIButton *xButton;
}
//
//@property NSDictionary *getMealDictionaryJSON;
//@property NSMutableArray *arrayOfMeals;
//@property NSString *identification;

//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs

static const int MAX_BUFFER_SIZE = 2; // max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; // height of the draggable card
static const float CARD_WIDTH = 290; // width of the draggable card

@synthesize exampleCardLabels; // all the labels I'm using as example data at the moment
@synthesize allCards;// all the cards

@synthesize user;

#pragma mark - Don't Forget to Initialize Meal With Card

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [super layoutSubviews];
        [self setupView];
    }
        return self;
}

#pragma mark - Change Me Method

-(void)loadMeals{
    
}

-(void)getMealInfo:(NSString *)token
{

    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];

    NSURL *url = [NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/random_meals"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];


    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error != nil) {
            NSLog(@"---> ERROR :: %@", error);
        }

        dispatch_async(dispatch_get_main_queue(), ^{

            self.user.token = token; //THIS IS JUST HERE UNTIL I FIND A BETTER WAY TO GO ABOUT MANAGING THE TOKEN STUFF.

            getMealDictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            arrayOfMealDictionaries = [getMealDictionaryJSON objectForKey:@"meals"];
            arrayOfMeals = [NSMutableArray new];
            for (NSDictionary *dict in arrayOfMealDictionaries) {
                Meal *meal = [[Meal alloc] initMealWithContentsOfDictionary:dict];
                [arrayOfMeals addObject:meal];
            }

            //What is the relationship between "all cards" and exampleCardLabels?
            //What is the relationship between "loadedCard" and exampleCardLabels?

            //Here's my attempt to switch arrayOfMeals over from ecl to allCards
            self.arrayOfExampleMeals = [NSMutableArray new];
            Meal *meal1 = [arrayOfMeals objectAtIndex:0];
            Meal *meal2 = [arrayOfMeals objectAtIndex:1];
            Meal *meal3 = [arrayOfMeals objectAtIndex:2];
            [self.arrayOfExampleMeals addObject:meal1];
            [self.arrayOfExampleMeals addObject:meal2];
            [self.arrayOfExampleMeals addObject:meal3];

            NSLog(@"@%", meal1.mealName);

//            for (Meal *meal in arrayOfExampleMeals) {
//                SwipedCardView *card = [SwipedCardView new];
//                card.meal = meal;
//            } //DO THIS IN createSwipeCardViewWithDataAtIndex


//            exampleCardLabels = [arrayOfExampleMeals copy]; // instead of setting this to an array of meals, call a method that spits out an array of cards ....
            exampleCardLabels = [[NSMutableArray alloc]init];

            loadedCards = [[NSMutableArray alloc] init];
            //            allCards = [arrayOfMeals copy];
            allCards = [arrayOfMeals copy];


//            exampleCardLabels = [arrayOfMeals copy];
//            loadedCards = [[NSMutableArray alloc] init];
////            allCards = [arrayOfMeals copy];
//            allCards = [[NSMutableArray alloc] init];  //Need an Array of Swiped Card Views With a Meal Property Not an Array of Meals
            cardsLoadedIndex = 0;
            [self loadCards]; //NEEDS TO TAKE IN A PROPERTY OF THE EXAMPLE MEALS
        });
    }];
    
    [task resume];
    
}

-(void)postMealToToTryArray:(id)identification toUserWithToken:(NSString *)token{
    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];

    NSString *base_url = @"http://tasteswipe-int.herokuapp.com/";
    NSString *mealID = identification; //
    NSString *path =@"/meal/";
    NSString *after_id = @"/right";

    NSString *base_postRequest = [NSString stringWithFormat:@"meal/%@/right", identification];


//    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",base_url,path,mealID,after_id]];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",base_url,base_postRequest]];

    NSLog(@"%@", url);

//    [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",base_url]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/meal/2/right"]];


    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];


    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        //do stuff
    }];
    [postDataTask resume];
}


#pragma mark - Extra Button Setup

-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 485, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 485, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

#pragma mark - Add MEAL INFO include own card customization here!
//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)



-(SwipedCardView *)createSwipedCardViewWithDataAtIndex:(NSInteger)index
{
    SwipedCardView *swipedCardView = [[SwipedCardView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)]; //Take in a Meal as a vairable

//    Meal *swipedMeal = [[exampleCardLabels objectAtIndex:index] meal]; //shoot me now!
//    swipedCardView.meal = [[]]
//    Meal *swipedMeal = [[allCards objectAtIndex:index] meal];
//    Meal *swipedMeal = [allCards objectAtIndex:index];

//    swipedCardView.meal = arrayOfExampleMeals[index];

//    swipedCardView.information.text = swipedMeal.mealName;
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: swipedMeal.mealImageURL]];
//    swipedCardView.mealPicture.image = [UIImage imageWithData: imageData];

//    NSLog(swipedMeal.mealImageURL);

//    swipedCardView.information.text = [exampleCardLabels objectAtIndex:index];
    swipedCardView.delegate = self;
    return swipedCardView;
}


#pragma mark - CHANGE exampleCardLabels

//%%% loads all the cards and puts the first x in the "loaded cards" array

-(void)loadCards
{
    if([self.arrayOfExampleMeals count] > 0) { //changed from exampleCardLabels

        //
        NSInteger numLoadedCardsCap =(([exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardLabels count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen

        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data


//        for (int i = 0; i<[exampleCardLabels count]; i++) {
//            SwipedCardView* newCard = [self createSwipedCardViewWithDataAtIndex:i];
        for (int i = 0; i<[self.arrayOfExampleMeals count]; i++) {
                SwipedCardView* newCard = [self createSwipedCardViewWithDataAtIndex:i];
            newCard.meal = self.arrayOfExampleMeals[i];
            NSLog(@"%@", self.arrayOfExampleMeals);
            newCard.information.text = newCard.meal.mealName;
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: newCard.meal.mealImageURL]];
            newCard.mealPicture.image = [UIImage imageWithData: imageData];
            NSLog(@"%lu", exampleCardLabels.count);
            NSLog(@"text --> %@", newCard.information.text);

            [exampleCardLabels addObject:newCard];




            //SwipedCardView
//            [allCards addObject:newCard]; -- is this needed?

//            newCard.meal = [arrayOfMeals objectAtIndex:i];  I THINK THIS NEEDS TO BE LOADED IN THE CREATESWIPCARDVIEWWITH DATAATINDEX METHOD

            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }

        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment

        }
    }
}


#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    SwipedCardView *c = (SwipedCardView *)card;

    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    NSLog(@"test");

    //ADD THE MEAL FROM THE SWIPED CARD TO THE ARRAY METHOD HERE

    //NEED A METHOD THAT INCREASES THE OBJECT AT INDEX BY ONE FOR EVERY SUBSEQUENT SWIPE ----OR----- probably better solution.... base the meal on the Swiped View

    [self postMealToToTryArray:[[exampleCardLabels objectAtIndex:0] mealID] toUserWithToken:self.user.token]; //instead of exampleCardLabels objectAtIndex:0, the logic should be tied to the meal that was instantiated with the card...... NEED TO DO THIS NOW.  ALSO THE WAY TOKEN IS BEING HANDLED HERE IS PROBABLY PLACEHOLDER-ESQUE TOO

    NSLog(@"loadedCard mealName is --> %@",[[exampleCardLabels objectAtIndex:0] mealName]);

    //POST [exampleCardLabels objectAtIndex:0]

    //do whatever you want with the card that was swiped
    //    SwipedCardView *c = (SwipedCardView *)card;

    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }

}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    SwipedCardView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    SwipedCardView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
