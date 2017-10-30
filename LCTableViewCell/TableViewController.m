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
@property (nonatomic, strong) UIButton *deleteButton;//删除按钮
@property (nonatomic, strong) UIButton *downLoadButton;//下载按钮
@property (nonatomic, assign) NSIndexPath *editingIndexPath;

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
            model.descriptionStr=@"https://github.com/LuochuanAD  https://github.com/LuochuanAD/OC-LCTableViewCell 有问题,请留言. ";
        }
        model.hasDownload=@"0";//初始时默认未下载,该字段可以通过接口来获取
        [mutArray addObject:model];
    }
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self configIOS11ForCustomCellButton];
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
//iOS10及以下
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  return @"                  ";//这里空格的长度是显示多个按钮的长度和
    
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
    
}
//iOS11及以上
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos){
    UIContextualAction *action=[UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"         " handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
    }];//这里空格的长度是显示单个按钮的长度
    UISwipeActionsConfiguration *ac=[UISwipeActionsConfiguration configurationWithActions:@[action,action]];
    
    return ac;
}

//删除按钮处理事件
- (void)cellDeleteButtonClickedWithCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath=self.editingIndexPath;//[self.tableView indexPathForCell:cell];//通过传过来的cell 获取indexPath
     [mutArray removeObjectAtIndex:indexPath.row];//删除数据中的数据
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];//刷新行
    if (IOS11) {
        [self.tableView reloadData];
    }
    
}
//下载按钮处理事件
- (void)cellDownLoadButtonClickedWithCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath=self.editingIndexPath;//[self.tableView indexPathForCell:cell];
    LCSourcesModel *model=mutArray[indexPath.row];
    if ([model.hasDownload isEqualToString:@"1"]) {
        model.hasDownload=@"0";
    }else{
        model.hasDownload=@"1";
    }
    LCDeleteTableViewCell *nowCell=(LCDeleteTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [nowCell setContentViewSourceModel:model];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];//刷新行
    if (IOS11) {
        [self.tableView reloadData];
    }
}
- (void)configIOS11ForCustomCellButton{
    if (IOS11) {
        for (UIView *subview in self.tableView.subviews)
        {
            
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
            {//Xocde8
                for (UIView *subsubview in subview.subviews)
                {
                    if ([subsubview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
                    {
                        [self createCustomCellButton:subsubview];
                    }
                }
            }else if([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]){//Xcode9
                [self createCustomCellButton:subview];
            }
        }
    }
    
}
- (void)createCustomCellButton:(UIView *)cellView{
    cellView.backgroundColor=[UIColor lightGrayColor];
    
    for (UIView *btn in cellView.subviews) {

        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];//将系统原生的删除按钮remove掉

        }
    }
    _deleteButton=[self createDeleteButton];
    _deleteButton.frame=CGRectMake(0, 0, cellView.frame.size.width/2, cellView.frame.size.height);
    
    [cellView addSubview:_deleteButton];
    _downLoadButton=[self createDownLoadButton];
    _downLoadButton.frame=CGRectMake(cellView.frame.size.width/2, 0, cellView.frame.size.width/2, cellView.frame.size.height);
    
    LCSourcesModel *model=mutArray[self.editingIndexPath.row];
    if ([model.hasDownload isEqualToString:@"1"]) {
        [_downLoadButton setTitle:@"已下载" forState:UIControlStateNormal];
    }else{
        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
    }

    [cellView addSubview:_downLoadButton];
    
}
//懒加载
- (UIButton *)createDeleteButton{
    if (!_deleteButton) {
        _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor=[UIColor grayColor];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_deleteButton addTarget:self action:@selector(cellDeleteButtonClickedWithCell:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
//懒加载
- (UIButton *)createDownLoadButton{
    if (!_downLoadButton) {
        _downLoadButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _downLoadButton.backgroundColor=[UIColor orangeColor];
        _downLoadButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_downLoadButton addTarget:self action:@selector(cellDownLoadButtonClickedWithCell:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadButton;
}


@end
