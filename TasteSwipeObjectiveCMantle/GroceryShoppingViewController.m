//
//  GroceryShoppingViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Michelle Burke on 11/5/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "GroceryShoppingViewController.h"

@interface GroceryShoppingViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property NSArray *grocery;

@end

@implementation GroceryShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.grocery.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroceryShopping" forIndexPath:indexPath];
    cell.textLabel.text = self.grocery;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
