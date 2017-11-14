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
@property (weak, nonatomic) IBOutlet UITableView *singleTable;

/** <#description#> */
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation RCTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.subTable.delegate = self;
    self.subTable.dataSource = self;
    self.singleTable.delegate = self;
    self.singleTable.dataSource = self;
}

- (void)setTableType:(RCTableViewType)tableType {
    _tableType = tableType;
    if (_tableType == RCTableViewTypeAllLocation) {
        self.singleTable.hidden = true;
        self.mainTable.hidden = false;
        self.subTable.hidden = true;
    } else {
        self.singleTable.hidden = false;
        self.mainTable.hidden = true;
        self.subTable.hidden = true;
    }
}

+ (instancetype)shareInstanceManagerWithType:(RCTableViewType)type {
    RCTableView *instance = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    instance.tableType = type;
    instance.backgroundColor = [UIColor whiteColor];
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //代码
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestrueMethod:)];
//        tapGesture.delegate = self;
//        tapGesture.numberOfTapsRequired = 1;
//        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"touch.view.tag = %zd", touch.view.tag);
    if (touch.view.tag == 100 ||
        touch.view.tag == 101 ||
        touch.view.tag == 102) {
        return false;
    }
    return true;
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
//    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [view addSubview:self];
}

- (void)hide {
//    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTable) {
        return 5;
    } else if (tableView == self.subTable) {
        return 3;
    } else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mainCellId = @"mainCell";
    static NSString *subCellId = @"subCell";
    static NSString *singleCellId = @"singleCell";
    
    if (tableView == self.mainTable) {
        UITableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
        if (!mainCell) {
            mainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellId];
        }
        mainCell.textLabel.text = [NSString stringWithFormat:@"mainCell-%zd", indexPath.row];
        return mainCell;
    } else if (tableView == self.subTable) {
        UITableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:subCellId];
        if (!subCell) {
            subCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCellId];
        }
        subCell.textLabel.text = [NSString stringWithFormat:@"subCell-%zd", indexPath.row];
        return subCell;
    } else {
        UITableViewCell *singleCell = [tableView dequeueReusableCellWithIdentifier:singleCellId];
        if (!singleCell) {
            singleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:singleCellId];
        }
        singleCell.textLabel.text = [NSString stringWithFormat:@"singleCell-%zd", indexPath.row];
        return singleCell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableType == RCTableViewTypeAllLocation && tableView == self.mainTable) {
        self.selectedArray = [NSMutableArray new];
        [self.selectedArray addObject:[NSString stringWithFormat:@"mainCell-%zd", indexPath.row]];
        self.subTable.hidden = false;
    }
    
    if (self.tableType == RCTableViewTypeAllLocation && tableView == self.subTable) {
        [self.selectedArray addObject:[NSString stringWithFormat:@"subCell-%zd", indexPath.row]];
        [self hide];
    }
    
    if (self.tableType == RCTableViewTypeAllCategory) {
        self.selectedArray = [NSMutableArray new];
        [self.selectedArray addObject:[NSString stringWithFormat:@"mainCell-%zd", indexPath.row]];
        [self hide];
    }
    
    if (self.tableType == RCTableViewTypeAuto) {
        self.selectedArray = [NSMutableArray new];
        [self.selectedArray addObject:[NSString stringWithFormat:@"mainCell-%zd", indexPath.row]];
        [self hide];
    }
    
    if ([self.delegate respondsToSelector:@selector(touchTableWithType:content:)]) {
        [self.delegate touchTableWithType:self.tableType content:self.selectedArray];
    }
}

#pragma mark - Custom Method


- (IBAction)touchAllCategoryBtn:(id)sender {
    self.tableType = RCTableViewTypeAllCategory;
}

- (IBAction)touchAllLocationBtn:(id)sender {
    self.tableType = RCTableViewTypeAllLocation;
}

- (IBAction)touchAutoBtn:(id)sender {
    self.tableType = RCTableViewTypeAuto;
}










@end
