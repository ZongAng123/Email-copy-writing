//
//  MailTableViewController.m
//  邮箱仿写
//
//  Created by 纵昂 on 2017/2/23.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "MailTableViewController.h"

@interface MailTableViewController ()
@property(nonatomic,strong)NSArray *itemsArray;
@end
@implementation MailTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshAction{
    // 结束刷新
    [self.refreshControl endRefreshing];
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


@end
