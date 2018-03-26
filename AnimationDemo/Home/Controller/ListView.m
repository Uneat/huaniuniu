//
//  ListView.m
//  AnimationDemo
//
//  Created by Orient on 2018/1/22.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "ListView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.frame = CGRectMake(SCREEN_WIDTH - 100, 64, 100, 159);
        [self setBackgroundColor:[UIColor whiteColor]];
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        self.tableView.rowHeight = 53;
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.tableView];
       
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"DeviceCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"过程动画";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"转换动画";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"自带动画";
        }
            break;
        case 3:
        {
//            cell.textLabel.text = @"仿射变换";
        }
            break;
        case 4:
        {
//            cell.textLabel.text = @"简单运用";
        }
            break;
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%ld",(long)indexPath.row);
    [self.delegate pushViewControllers:indexPath.row];
    
}


@end
