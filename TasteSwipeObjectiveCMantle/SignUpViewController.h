//
//  SignUpViewController.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/9/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;


@end
