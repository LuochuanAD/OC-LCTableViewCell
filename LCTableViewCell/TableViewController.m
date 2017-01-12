//
//  TableViewController.m
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TableViewController.h"
#import "LCDeleteTableViewCell.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource,CellButtonClickedDelegate>
{
    NSMutableArray *mutArray;//数据源
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    mutArray =[[NSMutableArray alloc]initWithObjects:@[@{@"top":@"a"},@{@"top1":@"b"},@{@"top2":@"c"}],@[@{@"top":@"aa"},@{@"top1":@"bb"},@{@"top2":@"cc"}],@[@{@"top":@"aaa"},@{@"top1":@"bbb"},@{@"top2":@"ccc"}], nil];
    NSLog(@"%@",mutArray);
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=50;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strID=@"strID";
    LCDeleteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell=[[LCDeleteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    cell.tag=indexPath.row+100;//重要:标记cell的tag值
    [cell setMessageForCellString1:[mutArray[indexPath.row][0] objectForKey:@"top"] withString2:[mutArray[indexPath.row][1] objectForKey:@"top1"] withString3:[mutArray[indexPath.row][2] objectForKey:@"top2"]];
    cell.delegate=self;//设置代理
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//此方法不走,但是必须要写
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  return @"                  ";//这里空格的长度是显示多个按钮的长度和
    
}
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



@end
