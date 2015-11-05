//
//  Meal.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/5/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "Meal.h"

@implementation Meal

- (instancetype)initMealWithContentsOfDictionary:(NSDictionary *)mealDictionary
{
    self = [super init];
    if(self)
    {
        self.mealID = [mealDictionary objectForKey:@"id"];
        self.mealName = [mealDictionary objectForKey:@"name"];
        self.mealDescription =[mealDictionary objectForKey:@"description"];
        self.mealImageURL = [mealDictionary objectForKey:@"image_url"];
        self.mealConsumablesArray = [mealDictionary objectForKey:@"consumables"];
    }

    return self;
}

@end
