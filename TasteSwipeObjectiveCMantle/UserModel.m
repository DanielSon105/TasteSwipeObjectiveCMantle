//
//  UserModel.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/4/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

// keys in the JSON you care about, and which property they map to.  @{ localPropertyName : jsonKey, ... }
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identifier"  : @"id",
             @"name"        : @"name",
             @"url"         : @"user_url",
             @"createdAt"   : @"created_at",
             @"bestFriend"  : @"best_friend",
             @"closestFriends" : @"friends"
             };
}

// note the pattern JSONTransformer
+ (NSValueTransformer *)urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

// mapping a nested Model
+ (NSValueTransformer *)bestFriendJSONTransformer {

//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *userDict) {
//        return [MTLJSONAdapter modelOfClass: UserModel.class
//                         fromJSONDictionary: userDict
//                                      error: nil];
//    } reverseBlock:^(UserModel *user) {
//        return [MTLJSONAdapter JSONDictionaryFromModel: user];
//    }];

    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *userDict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:UserModel.class fromJSONDictionary:userDict error:nil];
    } reverseBlock:^id(UserModel *user, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter JSONDictionaryFromModel: user error:nil];
    }];
}


+ (NSValueTransformer*)closestFriendsJSONTransformer
{
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[UserModel class]];

    return [MTLJSONAdapter arrayTransformerWithModelClass:[UserModel class]];
}

// mapping a NSDate with formats specific to your application's back end
+ (NSValueTransformer *)completedAtJSONTransformer {

//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
//        return [self.dateFormatter dateFromString:str];
//    } reverseBlock:^(NSDate *date) {
//        return [self.dateFormatter stringFromDate:date];
//    }];

    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *str, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

// by the way, creating NSDateFormatters is expensive.  So we create a static instance...
+ (NSDateFormatter *)dateFormatter {

    static NSDateFormatter *kDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDateFormatter = [[NSDateFormatter alloc] init];
        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        kDateFormatter.dateFormat = @"yyyy-MM-dd";  // you configure this based on the strings that your webservice uses!!
    });

    return kDateFormatter;
}


@end