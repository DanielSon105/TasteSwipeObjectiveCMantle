//
//  Meal.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/5/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject

- (instancetype)initMealWithContentsOfDictionary:(NSDictionary *)mealDictionary;

@property NSString *mealID;
@property NSString *mealName;
@property NSString *mealDescription;
@property NSString *mealImageURL;
@property NSArray *mealConsumablesArray;

@end
