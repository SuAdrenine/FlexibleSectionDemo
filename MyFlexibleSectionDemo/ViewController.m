//
//  ViewController.m
//  MyFlexibleSectionDemo
//
//  Created by xiebangyao on 2017/1/2.
//  Copyright © 2017年 xiebangyao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, copy) NSMutableArray *titleArr;
@property(nonatomic, copy) NSMutableArray *dataArr;
@property(nonatomic, copy) NSMutableDictionary *dataDic;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"array = %@",self.dataArr);
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Datasource & Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    if ([[self.dataDic valueForKey:key] isEqualToString:@"1"]) {
        return [self.dataArr[section] count];
    } else {
        return 0;
    }
}

static NSString *reuseIdentifier = @"reuseIdentifier";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - getter & setter
-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"中国",@"越南",@"巴基斯坦"],@[@"英国",@"法国",@"德国",@"意大利"],@[@"加拿大",@"美国",@"墨西哥"],@[@"埃及",@"刚果"]].mutableCopy;
    }
    
    return _dataArr;
}

-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"亚洲",@"欧洲",@"美洲",@"非洲"].mutableCopy;
    }
    
    return _titleArr;
}

-(NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"1",
                                                                   @"1":@"1",
                                                                   @"2":@"1",
                                                                   @"3":@"1"
                                                                   }];
    }
    
    return _dataDic;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
//        _tableView.sectionHeaderHeight = 0.1;
        _tableView.sectionFooterHeight = 0.1;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        //        [_tableView registerClass:[MySectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"MySectionHeaderView"];
    }
    
    return _tableView;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

// 在返回头视图的方法里面给每个区添加一个button
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 把分区的头视图设置成Button
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    // 设置Button的标题作为section的标题用
    [button setTitle:self.titleArr[section] forState:UIControlStateNormal];
    // 设置点击事件
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchDown)];
    // 给定tag值用于确定点击的对象是哪个区
    button.tag = section + 1000;
    return button;
}

// 设置Button的点击事件
- (void)buttonAction:(UIButton *)sender
{
    NSInteger temp = sender.tag - 1000;
    // 修改 每个区的收缩状态  因为每次点击后对应的状态改变 temp代表是哪个section
    if ([[self.dataDic valueForKey:[NSString stringWithFormat:@"%ld",temp]]isEqualToString:@"0"] )
    {
        [self.dataDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",temp]];
    }else
    {
        [self.dataDic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",temp]];
    }
    // 更新 section
    //    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:(UITableViewRowAnimationFade)];
    
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

@end
