# OC-LCTableViewCell
基于系统原生左划出现多个按钮


![image](http://img.blog.csdn.net/20170731161858825)

这个效果是基于系统原生的.
首先创建自定义cell 命名:LCDeleteTableViewCell,继承UITableViewCell. 这里的效果1图显示的是2个按钮,所以我们要便利cell的子视图,将原来系统的一个按钮remove掉,添加我们自定义的2个按钮到视图上.注意:这里的视图类型是:UITableViewCellDeleteConfirmationView 
以下是代码片段:
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
我个人比较喜欢用代理封装. 所以我设置协议CellButtonClickedDelegate定义2个方法,参数是UITableViewCell.  代码如下:
#import <UIKit/UIKit.h>
#import "LCSourcesModel.h"
@protocol CellButtonClickedDelegate <NSObject>

- (void)cellDeleteButtonClickedWithCell:(UITableViewCell *)cell;
- (void)cellDownLoadButtonClickedWithCell:(UITableViewCell *)cell;
@end


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
在TableViewViewController.m中我们遵守协议,并设置代理. 同时左划需要设置一下2按钮的宽度,方法如下:
[objc] view plain copy
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{  
  return @"                  ";//这里空格的长度是显示多个按钮的长度和  
      
}  
注:这里是通过输入空格的多少来显示多个按钮的总长度.

接下来需要在控制器中处理删除和下载2个按钮的事件:
//删除按钮处理事件
- (void)cellDeleteButtonClickedWithCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];//通过传过来的cell 获取indexPath
     [mutArray removeObjectAtIndex:indexPath.row];//删除数据中的数据
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];//刷新行
    
}
//下载按钮处理事件
- (void)cellDownLoadButtonClickedWithCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    LCSourcesModel *model=mutArray[indexPath.row];
    if ([model.hasDownload isEqualToString:@"1"]) {
        model.hasDownload=@"0";
    }else{
        model.hasDownload=@"1";
    }
    LCDeleteTableViewCell *nowCell=(LCDeleteTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [nowCell setContentViewSourceModel:model];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];//刷新行
    
}

 
 博文地址:http://blog.csdn.net/luochuanad/article/details/54406642
