//
//  MailBoxTableViewController.m
//  邮箱仿写
//
//  Created by 纵昂 on 2017/2/23.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "MailBoxTableViewController.h"
#import "MailTableViewController.h"

@interface MailBoxTableViewController ()
@property(nonatomic,strong)NSArray *itemsArray;
@end

@implementation MailBoxTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = @"邮箱";
    [self.editButtonItem setTitle:@"编辑"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    
    self.itemsArray = @[@[@{@"name" : @"收件箱", @"imageName" : @"inbox"},
                          @{@"name" : @"VIP", @"imageName" : @"star"},
                          @{@"name" : @"已发送", @"imageName" : @"send"},
                          @{@"name" : @"废纸篓", @"imageName" : @"trash"}],
                        @[@{@"name" : @"已发送", @"imageName" : @"send"},
                          @{@"name" : @"废纸篓", @"imageName" : @"trash"}]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reusedcell"];
}
- (void)refreshAction{
    // 结束刷新
    [self.refreshControl endRefreshing];
}

//显示右侧的移动按钮//返回YES，表示支持单元格的移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    //    需要的移动行
    //    NSInteger fromRow = [sourceIndexPath row];
    //    //    获取移动某处的位置
    //    NSInteger toRow = [destinationIndexPath row];
    //    //    从数组中读取需要移动行的数据
    //    id object = [self.listData objectAtIndex:fromRow];
    //    //    在数组中移动需要移动的行的数据
    //    [self.listData removeObjectAtIndex:fromRow];
    //    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
    //    [self.listData insertObject:object atIndex:toRow];
}
//显示左侧的选择按钮
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
//UIViewController生命周期方法，用于响应视图编辑状态变化
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
    if (self.editing) {
        self.editButtonItem.title = @"完成";
    } else {
        self.editButtonItem.title = @"编辑";
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.itemsArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusedcell" forIndexPath:indexPath];
    // Configure the cell...
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *tempdic = [[self.itemsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [[UIImage imageNamed:[tempdic valueForKey:@"imageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.textLabel.text = [tempdic valueForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MailTableViewController *mailVC = [[MailTableViewController alloc]initWithStyle:UITableViewStylePlain];
    mailVC.title = [[[self.itemsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"name"];
    [self.navigationController pushViewController:mailVC animated:YES];
}

@end
