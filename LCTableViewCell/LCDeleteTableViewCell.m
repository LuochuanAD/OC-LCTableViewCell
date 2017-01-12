//
//  LCDeleteTableViewCell.m
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCDeleteTableViewCell.h"
#define WINDOWS [UIScreen mainScreen].bounds.size


@interface LCDeleteTableViewCell()

@property (nonatomic)UILabel *lable1;
@property (nonatomic)UILabel *lable2;
@property (nonatomic)UILabel *lable3;
@end
@implementation LCDeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{
    [self createManyButton];//创建cell右划出现的多个按钮
}

- (void)createManyButton{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            subView.backgroundColor=[UIColor lightGrayColor];
            for (UIButton *btn in subView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    [btn removeFromSuperview];//将系统原生的删除按钮remove掉
                }
            }
            //在此自定义多个按钮,并添加(注:添加到的视图类型是:@"UITableViewCellDeleteConfirmationView")
            UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
            button1.backgroundColor=[UIColor redColor];
            button1.frame=CGRectMake(0, 0, subView.frame.size.width/2, subView.frame.size.height);
            [button1 setTitle:@"删除" forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [subView addSubview:button1];
            UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
            button2.backgroundColor=[UIColor orangeColor];
            button2.frame=CGRectMake(subView.frame.size.width/2, 0, subView.frame.size.width/2, subView.frame.size.height);
            [button2 setTitle:@"下载" forState:UIControlStateNormal];
            [button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [subView addSubview:button2];
        }
    }

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//cell上展示的布局
        _lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOWS.width, 15)];
        _lable2=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, WINDOWS.width, 15)];
        _lable3=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, WINDOWS.width, 15)];
        [self addSubview:_lable1];
        [self addSubview:_lable2];
        [self addSubview:_lable3];
    }
    return self;
}
- (void)setMessageForCellString1:(NSString *)str1 withString2:(NSString *)str2 withString3:(NSString *)str3{//赋值
    _lable1.text=[NSString stringWithFormat:@"%@",str1];
    _lable2.text=[NSString stringWithFormat:@"%@",str2];
    _lable3.text=[NSString stringWithFormat:@"%@",str3];

}
- (void)button1Clicked:(UIButton *)button1{
    if ([self.delegate respondsToSelector:@selector(cellDeletebuttonClickedWithCell:)]) {
        [self.delegate cellDeletebuttonClickedWithCell:self];
    }
}
- (void)button2Clicked:(UIButton *)button2{
    if ([self.delegate respondsToSelector:@selector(cellSetTopbuttonClickedWithCell:)]) {
        [self.delegate cellSetTopbuttonClickedWithCell:self];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
