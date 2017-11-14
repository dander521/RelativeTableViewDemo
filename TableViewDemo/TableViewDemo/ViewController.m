//
//  ViewController.m
//  TableViewDemo
//
//  Created by 程荣刚 on 2017/11/7.
//  Copyright © 2017年 程荣刚. All rights reserved.
//

#import "ViewController.h"
#import "RCTableView.h"

@interface ViewController ()<RCTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchShowBtm:(id)sender {
    RCTableView *relativeTab = [RCTableView shareInstanceManagerWithType:RCTableViewTypeAllLocation];
    relativeTab.delegate = self;
    [relativeTab show];
}

- (void)touchTableWithType:(RCTableViewType)tableType content:(NSArray *)content {
    NSLog(@"tableType = %zd, content = %@", tableType, content);
}

@end
