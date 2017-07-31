//
//  TableViewController.m
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TableViewController.h"
#import "LCDeleteTableViewCell.h"
#import "LCSourcesModel.h"
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource,CellButtonClickedDelegate>
{
    NSMutableArray *mutArray;//数据源
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"系统效果左划多个按钮";
    
    
    mutArray =[[NSMutableArray alloc]init];
    NSLog(@"%@",mutArray);
    for (int i=0; i<10; i++) {
        LCSourcesModel *model=[[LCSourcesModel alloc]init];
        model.nameStr=[NSString stringWithFormat:@"%02d",i];
        model.webAddressStr=[NSString stringWithFormat:@"https://github.com/LuochuanAD/OC-LCTableViewCell"];
        if (i<3) {
            model.descriptionStr=@"https://github.com/LuochuanAD";
        }else if (i>=3&&i<6){
            model.descriptionStr=@"https://github.com/LuochuanAD  https://github.com/LuochuanAD/OC-LCTableViewCell";
        }else{
            model.descriptionStr=@"https://github.com/LuochuanAD  https://github.com/LuochuanAD/OC-LCTableViewCell  QQ群:458922248 当前人数为个位,自愿哦. ";
        }
        model.hasDownload=@"0";//初始时默认未下载,该字段可以通过接口来获取
        [mutArray addObject:model];
    }
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
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
        cell.delegate=self;//设置代理
    }
    LCSourcesModel *model=mutArray[indexPath.row];
    [cell setContentViewSourceModel:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //动态cell的高度
    LCSourcesModel *model=mutArray[indexPath.row];
    return model.cellHeight;
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


@end
