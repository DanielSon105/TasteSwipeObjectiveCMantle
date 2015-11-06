//
//  ToTryListViewController.m
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/6/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "ToTryListViewController.h"
#import "ToTryListTableViewCell.h"

@interface ToTryListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ToTryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

#pragma mark - UITableView Methods (Including Delegate Methods)

-(ToTryListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ToTryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToTryCell"];



    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
