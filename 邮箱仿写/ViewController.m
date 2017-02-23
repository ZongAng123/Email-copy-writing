//
//  ViewController.m
//  邮箱仿写
//
//  Created by 纵昂 on 2017/2/23.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "ViewController.h"
#import "MailBoxTableViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UIBarButtonItem *itemtitle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self refreshTitle];
}
- (void)refreshTitle
{
    if (!self.itemtitle) {
        UIToolbar *bottombar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-44, CGRectGetWidth(self.view.frame), 44)];
        NSMutableArray *baritems = [NSMutableArray array];
        UIBarButtonItem *itemleft = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *itemtitle = [[UIBarButtonItem alloc]initWithTitle:@"刚刚更新" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.itemtitle = itemtitle;
        UIBarButtonItem *itemright = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *itemnew = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil];
        [baritems addObjectsFromArray:@[itemleft,itemtitle,itemright,itemnew]];
        bottombar.items = baritems;
        [self.view addSubview:bottombar];
        
        //更新邮件视图
        [self layoutSubViews];
        
    }else {
        [self.itemtitle setTitle:@"刚刚更新"];
    }
}

#pragma mark -加载
- (void)layoutSubViews
{
    MailBoxTableViewController *mailVC = [[MailBoxTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *mailNav = [[UINavigationController alloc]initWithRootViewController:mailVC];
    //在此处设置frame
    mailNav.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-45);
    [self addChildViewController:mailNav];
    [self.view addSubview:mailNav.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
