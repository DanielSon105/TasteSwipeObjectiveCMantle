//
//  SwipedCardBackgroundView.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipedCardView.h"
#import "User.h"

@interface SwipedCardBackgroundView : UIView <SwipedCardViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

-(void)changeMeMethod;
-(void)getMealInfo:(NSString *)token;

@property (retain,nonatomic)NSMutableArray* arrayOfExampleMeals;
@property (retain,nonatomic)NSMutableArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards
@property User *user;

@end
