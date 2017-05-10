# OC-LCTableViewCell
基于系统原生左划出现多个按钮


![image](http://img.blog.csdn.net/20170113110355434?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbHVvY2h1YW5BRA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

这个效果是基于系统原生的.
首先创建自定义cell 命名:LCDeleteTableViewCell,继承UITableViewCell. 这里的效果1图显示的是2个按钮,所以我们要便利cell的子视图,将原来系统的一个按钮remove掉,添加我们自定义的2个按钮到视图上.注意:这里的视图类型是:UITableViewCellDeleteConfirmationView 
以下是代码片段:
[objc] view plain copy
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
我个人比较喜欢用代理封装. 所以我设置协议CellButtonClickedDelegate定义2个方法,参数是UITableViewCell.  代码如下:
[objc] view plain copy
#import <UIKit/UIKit.h>  
@protocol CellButtonClickedDelegate <NSObject>  
- (void)cellDeletebuttonClickedWithCell:(UITableViewCell *)cell;  
- (void)cellSetTopbuttonClickedWithCell:(UITableViewCell *)cell;  
@end  
@interface LCDeleteTableViewCell : UITableViewCell  
@property (assign, nonatomic)id<CellButtonClickedDelegate> delegate;  
- (void)setMessageForCellString1:(NSString *)str1 withString2:(NSString *)str2 withString3:(NSString *)str3;  
@end  

[objc] view plain copy
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
在TableViewViewController.m中我们遵守协议,并设置代理. 同时左划需要设置一下2按钮的宽度,方法如下:
[objc] view plain copy
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{  
  return @"                  ";//这里空格的长度是显示多个按钮的长度和  
      
}  
注:这里是通过输入空格的多少来显示多个按钮的总长度.

接下来需要在控制器中处理删除和下载2个按钮的事件:
[objc] view plain copy
//删除按钮处理事件  
- (void)cellDeletebuttonClickedWithCell:(UITableViewCell *)cell{  
    NSLog(@"删除");  
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];//通过传过来的cell 获取indexPath  
     [mutArray removeObjectAtIndex:indexPath.row];//删除数据中的数据  
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];//刷新行  
      
}  
//下载按钮处理事件  
- (void)cellSetTopbuttonClickedWithCell:(UITableViewCell *)cell{  
    NSLog(@"下载");  
      
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];  
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];//刷新行  
 }  
 
 博文地址:http://blog.csdn.net/luochuanad/article/details/54406642
