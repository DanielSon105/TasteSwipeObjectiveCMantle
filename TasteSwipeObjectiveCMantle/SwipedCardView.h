//
//  SwipedCardView.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "Meal.h"

@protocol SwipedCardViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface SwipedCardView : UIView

@property (weak) id <SwipedCardViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)SwipedCardView* swipedCardView;
@property (nonatomic,strong)UILabel* information; //%%% a placeholder for any card-specific information
@property OverlayView *overlayView;

@property Meal *meal;

-(void)leftClickAction;
-(void)rightClickAction;

@end

//one of these SwipedCardView.h files comes with every card... therefore we need to add a Meal class property to it;