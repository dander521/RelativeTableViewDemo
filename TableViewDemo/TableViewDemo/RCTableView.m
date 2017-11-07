//
//  RCTableView.m
//  TableViewDemo
//
//  Created by 程荣刚 on 2017/11/7.
//  Copyright © 2017年 程荣刚. All rights reserved.
//

#import "RCTableView.h"

@interface RCTableView ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UITableView *subTable;

@end

@implementation RCTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.subTable.delegate = self;
    self.subTable.dataSource = self;
}

+ (instancetype)shareInstanceManager {
    RCTableView *instance = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //代码
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestrueMethod:)];
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
        
        
    }
    
    return self;
}

// 点击背景
- (void)tapGestrueMethod:(UITapGestureRecognizer *)gesture {
    [self hide];
}

- (void)show {
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

// 添加弹出移除的动画效果
- (void)showInView:(UIView *)view {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [view addSubview:self];
}

- (void)hide {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTable) {
        return 5;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mainCellId = @"mainCell";
    static NSString *subCellId = @"subCell";
    
    if (tableView == self.mainTable) {
        UITableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
        if (!mainCell) {
            mainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellId];
        }
        mainCell.textLabel.text = @"mainCell";
        return mainCell;
    } else {
        UITableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:subCellId];
        if (!subCell) {
            subCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCellId];
        }
        subCell.textLabel.text = @"subCell";
        return subCell;
    }
}

#pragma mark - UITableViewDelegate




@end
