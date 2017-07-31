//
//  LCDeleteTableViewCell.m
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCDeleteTableViewCell.h"
#import "LCSourcesModel.h"
#define WINDOWS [UIScreen mainScreen].bounds.size

@interface LCDeleteTableViewCell()
{
    NSString *downLoadLableText;
}
@end
@implementation LCDeleteTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLable=[[UILabel alloc]init];
        _webAddressLable=[[UILabel alloc]init];
        _descriptionLable=[[UILabel alloc]init];
        [self.contentView addSubview:_nameLable];
        [self.contentView addSubview:_webAddressLable];
        [self.contentView addSubview:_descriptionLable];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews{
    [self createManyButton];
    /**此处我加个判断,是为了防止cell的位置向右偏移,因为此种情况我在iOS10.3.2,iphone6s上出现了.此处为解决方法*/
    CGRect contentViewFrame = self.contentView.frame;
    if (contentViewFrame.origin.x>0) {
        contentViewFrame.origin.x=0;
        self.contentView.frame=contentViewFrame;
    }
    _nameLable.frame=CGRectMake(20, 10, 40, 30);
    _nameLable.textColor=[UIColor blackColor];
    
    _webAddressLable.frame=CGRectMake(CGRectGetMaxX(_nameLable.frame), CGRectGetMinY(_nameLable.frame),(WINDOWS.width-20*2)-40 , CGRectGetHeight(_nameLable.frame));
    _webAddressLable.textColor=[UIColor blackColor];
    _webAddressLable.adjustsFontSizeToFitWidth=YES;
    
    /**此时动态计算高度的控件的y坐标值为40.和LCSourcesModel的cellHeight设置的要一样*/
    _descriptionLable.frame=CGRectMake(CGRectGetMinX(_nameLable.frame), CGRectGetMaxY(_nameLable.frame), WINDOWS.width-20*2, CGRectGetHeight(self.frame)-CGRectGetMaxY(_nameLable.frame));//此处的descriptionLable是动态设置高度
    _descriptionLable.numberOfLines=0;
    _descriptionLable.textColor=[UIColor blackColor];
    /**注意:动态高度的控件的字号大小为固定的17.  和LCSourcesModel的cellHeight设置的字号要一样*/
    _descriptionLable.font=[UIFont systemFontOfSize:17];
    
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
            _deleteButton=[self createDeleteButton];
            _deleteButton.frame=CGRectMake(0, 0, subView.frame.size.width/2, subView.frame.size.height);
            [subView addSubview:_deleteButton];
            _downLoadButton=[self createDownLoadButton];
            _downLoadButton.frame=CGRectMake(subView.frame.size.width/2, 0, subView.frame.size.width/2, subView.frame.size.height);
            if (downLoadLableText.length==0) {
                downLoadLableText=@"下载";
            }
            [_downLoadButton setTitle:downLoadLableText forState:UIControlStateNormal];
            [subView addSubview:_downLoadButton];
        }
    }

}
//懒加载
- (UIButton *)createDeleteButton{
    if (!_deleteButton) {
        _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor=[UIColor redColor];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_deleteButton addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
//懒加载
- (UIButton *)createDownLoadButton{
    if (!_downLoadButton) {
        _downLoadButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _downLoadButton.backgroundColor=[UIColor orangeColor];
        _downLoadButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_downLoadButton addTarget:self action:@selector(downloadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadButton;
}
- (void)deleteBtnClicked:(UIButton *)button1{
    if ([self.delegate respondsToSelector:@selector(cellDeleteButtonClickedWithCell:)]) {
        [self.delegate cellDeleteButtonClickedWithCell:self];
    }
}
- (void)downloadBtnClicked:(UIButton *)button2{
    if ([self.delegate respondsToSelector:@selector(cellDownLoadButtonClickedWithCell:)]) {
        [self.delegate cellDownLoadButtonClickedWithCell:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setContentViewSourceModel:(LCSourcesModel *)model{
    _nameLable.text=[NSString stringWithFormat:@"%@",model.nameStr];
    _webAddressLable.text=[NSString stringWithFormat:@"%@",model.webAddressStr];
    _descriptionLable.text=[NSString stringWithFormat:@"%@",model.descriptionStr];
    if ([model.hasDownload isEqualToString:@"1"]) {
        downLoadLableText=@"已下载";
    }else{
        downLoadLableText=@"下载";
    }
    /**注:每次赋值之后,滑动cell后,都会调用layoutSubviews方法*/
}
@end
