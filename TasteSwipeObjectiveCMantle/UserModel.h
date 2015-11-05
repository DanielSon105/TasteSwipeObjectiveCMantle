//
//  UserModel.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Mantle/Mantle.h>

// to map key-value pairs in the incoming JSON to properties on your model, you need to
// support the MTLJSONSerializing protocol then instantiate your objects with the factory method
// [MTLJSONAdapter modelOfClass: fromJSONDictionary: error:]

@interface UserModel : MTLModel

@property (nonatomic, readonly, copy) NSNumber *identifier;  // i.e. userID
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSURL *url;  // i.e. get this object

@property (nonatomic, readonly, copy) NSDate *createdAt;
@property (nonatomic, readonly, copy) UserModel *bestFriend;
@property (nonatomic, readonly, copy) NSArray *closestFriends;

@end

//Then instantiating objects is as simple as:


//NSDictionary *jsonDict = kSomeParsedJSONDictionary;  // ... some user json you already have defined
//NSError *error = nil;  // yes, error handling!
//
//HS7UserModel *aUser = [MTLJSONAdapter modelOfClass: HS7UserModel.class fromJSONDictionary: jsonDict error: &error];
//
//if (error){
    // it will tell you what went wrong in the whole conversion process via this error.
//}
