//
//  ViewController.m
//  musicPlayer
//
//  Created by coohua on 15/7/10.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "TableViewController.h"

#import "MusicViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"播放列表";
    // 不显示分割线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"梁静茹-温柔";
    // 显示分割线
    cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicViewController *mVC = [[MusicViewController alloc] init];
//    self.navigationController.navigationBar.backItem.title = @"";
    mVC.navigationItem.title = @"温柔";
    [self.navigationController pushViewController:mVC animated:YES];
    
}
@end
