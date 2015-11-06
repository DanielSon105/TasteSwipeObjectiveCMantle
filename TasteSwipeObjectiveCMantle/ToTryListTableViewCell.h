//
//  ToTryListTableViewCell.h
//  TasteSwipeObjectiveCMantle
//
//  Created by Daniel Barrido on 11/6/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToTryListTableViewCellDelegate <NSObject> //defined a protocol in header

-(void)toTryListTableViewCell:(id)cell didTapButton:(UIButton *)button; //declared a method in our protocol

@end

@interface ToTryListTableViewCell : UITableViewCell

@end
