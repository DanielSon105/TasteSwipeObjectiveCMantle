//
//  User.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/5/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString *identification;
@property NSString *email;

@property NSString *token;



@property NSString *fullName;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *username;


@property BOOL isNormalUser;
@property BOOL isContributor;
@property BOOL isAdmin;



@property NSArray *toTryMealArray;
@property NSArray *hasTriedMealArray;

@end
