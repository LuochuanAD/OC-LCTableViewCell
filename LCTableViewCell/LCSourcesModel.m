//
//  LCSourcesModel.m
//  LCTableViewCell
//
//  Created by 罗川 on 2017/7/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCSourcesModel.h"

@implementation LCSourcesModel
- (CGFloat)cellHeight{
    //因为此刻是设置cell的动态高度,那么动态控件的宽度要和_descriptionlable的宽度一样. 动态计算该控件的内容高度,先给个最大float值
    CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-20*2, MAXFLOAT);
    NSString *content=[NSString stringWithFormat:@"%@",_descriptionStr];
    CGFloat textHeight=[content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    //该40为自定义cell中其他控件的高.
    _cellHeight=40+textHeight;
    return _cellHeight;
}
@end
