//
//  LCDeleteTableViewCell.h
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSourcesModel.h"
#define IOS11 @available(iOS 11.0, *)
@protocol CellButtonClickedDelegate <NSObject>

- (void)cellDeleteButtonClickedWithCell:(UITableViewCell *)cell;
- (void)cellDownLoadButtonClickedWithCell:(UITableViewCell *)cell;
@end

@interface LCDeleteTableViewCell : UITableViewCell
@property (weak, nonatomic)id<CellButtonClickedDelegate> delegate;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *webAddressLable;
@property (nonatomic, strong) UILabel *descriptionLable;
@property (nonatomic, strong) UIButton *deleteButton;//删除按钮
@property (nonatomic, strong) UIButton *downLoadButton;//下载按钮

- (void)setContentViewSourceModel:(LCSourcesModel *)model;
@end
