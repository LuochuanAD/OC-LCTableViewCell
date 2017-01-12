//
//  LCDeleteTableViewCell.h
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellButtonClickedDelegate <NSObject>

- (void)cellDeletebuttonClickedWithCell:(UITableViewCell *)cell;
- (void)cellSetTopbuttonClickedWithCell:(UITableViewCell *)cell;
@end


@interface LCDeleteTableViewCell : UITableViewCell
@property (assign, nonatomic)id<CellButtonClickedDelegate> delegate;
- (void)setMessageForCellString1:(NSString *)str1 withString2:(NSString *)str2 withString3:(NSString *)str3;
@end
