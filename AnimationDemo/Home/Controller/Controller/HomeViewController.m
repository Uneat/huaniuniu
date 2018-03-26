//
//  HomeViewController.m
//  AnimationDemo
//
//  Created by Orient on 2018/1/22.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "HomeViewController.h"
#import "ListView.h"
#import "ProcessViewController.h"
#import "ChangeViewController.h"
#import "OfficialViewController.h"
@interface HomeViewController () <pushVCDelegate>
@property (nonatomic, strong) NSArray * titleNameArray;
@property (nonatomic, strong) UIView * animationView;
@property (nonatomic, strong) ListView * listView;
@property (nonatomic, assign) BOOL isOpen;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"动画练习";
    self.isOpen = YES;
    [self createTitleButtons];
    [self createContentView];
    [self createLeftNavgationListButton];
    [self createAllAnimation];
    
    UIView * animationView1 = [[UIView alloc]init];
    animationView1.frame =CGRectMake(0, SCREEN_HEIGHT-80-64, 80, 80);
    [animationView1 setBackgroundColor:[UIColor purpleColor]];
    
    [self.view addSubview:animationView1];
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:150 * M_PI];
    animation.duration = 20.0f;
    [animationView1.layer addAnimation:animation forKey:@"rotate"];
    
    
    UIView * animationView2 = [[UIView alloc]init];
    animationView2.frame =CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT - 144, 80, 80);
    [animationView2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:animationView2];
    
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation1.toValue = [NSNumber numberWithFloat:150 * M_PI];
    animation1.duration = 20.0f;
    [animationView2.layer addAnimation:animation1 forKey:@"rotate"];
    
    
    UIView * animationView3 = [[UIView alloc]init];
    animationView3.frame =CGRectMake(SCREEN_WIDTH-80, 64, 80, 80);
    [animationView3 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:animationView3];
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.toValue = [NSNumber numberWithFloat:150 * M_PI];
    animation2.duration = 20.0f;
    [animationView3.layer addAnimation:animation2 forKey:@"rotate"];
    
    
    UIView * animationView4 = [[UIView alloc]init];
    animationView4.frame =CGRectMake(0, 64, 80, 80);
    [animationView4 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:animationView4];
    
    CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation3.toValue = [NSNumber numberWithFloat:150 * M_PI];
    animation3.duration = 20.0f;
    [animationView4.layer addAnimation:animation3 forKey:@"rotate"];
    
}

- (void)createAllAnimation{
    [self positionAnimation];
    [self opacityAniamtion];
    [self scaleAnimation];
    [self rotateAnimation];
    [self backgroundColorAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)titleNameArray{
    return [NSArray arrayWithObjects:@"飞奔",@"透明",@"缩放",@"旋转",@"颜色", nil];
}

- (void)createTitleButtons{
    
    for (NSInteger i=0; i<self.titleNameArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:[self buttonsSetPositionAtIndex:i]];
        [button setTag:i+1000];
        [button addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.titleNameArray[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
}
- (void)createContentView{
    UIView * animationView = [[UIView alloc]init];
    animationView.frame = [self animationViewLayout:animationView];
    animationView.center = self.view.center;
    [animationView setBackgroundColor:[UIColor cyanColor]];
    self.animationView = animationView;
    [self.view addSubview:self.animationView];
}
- (void)createLeftNavgationListButton{
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MoreIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(listClick:)];
    [rightItem setImageInsets:UIEdgeInsetsMake(10, 0, 0, 5)];
    
    [[self navigationItem] setRightBarButtonItem:rightItem];
    
   
 
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)buttonsClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1000:
            [self positionAnimation];
            break;
        case 1001:
            [self opacityAniamtion];
            break;
        case 1002:
            [self scaleAnimation];
            break;
        case 1003:
            [self rotateAnimation];
            break;
        case 1004:
            [self backgroundColorAnimation];
            break;
            
        default:
            break;
    }
}
- (void)listClick:(UIBarButtonItem *)rightButton{
    NSLog(@"list click !");
    if(self.isOpen){
        self.isOpen = NO;
        self.listView = [[ListView alloc]init];
        [self.listView setBackgroundColor:[UIColor whiteColor]];
        self.listView.delegate = self;
        [self.view addSubview:self.listView];
    }else{
        self.isOpen = YES;
        [self.listView setHidden:YES];
    }
   
}
#pragma mark layout -------->

- (CGRect)buttonsSetPositionAtIndex:(NSInteger)index{
    
    NSInteger margin = 8;
    NSInteger count = 5;
    NSInteger buttonWidth = ([[UIScreen mainScreen] bounds].size.width - (count+1) * margin) / count;
    NSInteger buttonHeight = 40;
    NSInteger marginLeftTotal = margin + index * (margin + buttonWidth);
    NSInteger marginTopTotal = [[UIScreen mainScreen] bounds].size.height - 64;
    
    return CGRectMake(marginLeftTotal, marginTopTotal, buttonWidth, buttonHeight);
}
- (CGRect)animationViewLayout:(UIView *)animationView{
    CGRect frame = animationView.frame;
    frame.size = CGSizeMake(100, 100);
    animationView.frame  = frame;
    animationView.layer.cornerRadius = 5;
    
    return frame;
}



#pragma mark Animation -------->
- (void)positionAnimation{
    NSLog(@"position");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.animationView.center.x, -100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.animationView.center.x, self.animationView.center.y)];
    animation.duration = 2.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.animationView.layer addAnimation:animation forKey:@"position"];
}
- (void)opacityAniamtion{
    NSLog(@"opacity");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.2f];
    animation.duration = 5.0f;
    [self.animationView.layer addAnimation:animation forKey:@"opacity"];
}
- (void)scaleAnimation{
    NSLog(@"scale");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:2.5f];
    animation.duration = 5.0f;
    [self.animationView.layer addAnimation:animation forKey:@"scale"];
}
- (void)rotateAnimation{
    NSLog(@"rotate");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:150 * M_PI];
    animation.duration = 20.0f;
    [self.animationView.layer addAnimation:animation forKey:@"rotate"];
}
- (void)backgroundColorAnimation{
    NSLog(@"backgroundColor");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    animation.toValue = (id)[UIColor ].CGColor;
    animation.toValue = (id)[UIColor greenColor].CGColor;
    animation.duration = 5.0f;
    [self.animationView.layer addAnimation:animation forKey:@"backgroundColor"];
}

#define mark delegate

- (void)pushViewControllers:(NSInteger)index{
    switch (index) {
        case 0:
        {
            ProcessViewController * processVC = [[ProcessViewController alloc]init];
            processVC.navigationItem.title =  @"过程动画";
            [self.navigationController pushViewController:processVC animated:YES];
        }
            break;
        case 1:
        {
            ChangeViewController * changeVC = [[ChangeViewController alloc]init];
            changeVC.navigationItem.title =  @"转换动画";
            [self.navigationController pushViewController:changeVC animated:YES];
        }
            break;
        case 2:
        {
            OfficialViewController * officialVC = [[OfficialViewController alloc]init];
            officialVC.navigationItem.title =  @"综合动画";
            [self.navigationController pushViewController:officialVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}













@end
