//
//  ListView.h
//  AnimationDemo
//
//  Created by Orient on 2018/1/22.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "RootView.h"
@protocol pushVCDelegate <NSObject>
@optional
- (void)pushViewControllers:(NSInteger)index;
@end
@interface ListView : RootView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray * dataSource;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, weak) id <pushVCDelegate> delegate;

//- (void)createTableView;
@end
