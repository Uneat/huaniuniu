//
//  ProcessViewController.m
//  AnimationDemo
//
//  Created by Orient on 2018/1/22.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "ProcessViewController.h"

@interface ProcessViewController ()<CAAnimationDelegate>
@property (nonatomic, strong)UIView *animationView;
@property (nonatomic, strong)NSArray * titleNameArray;
@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self createAnimationView];
    [self createTitleButtons];
    [self createCircular];
}
- (NSArray *)titleNameArray{
    return [NSArray arrayWithObjects:@"点路径",@"路径",@"颤抖", nil];
}

- (void)createCircular{
    for(NSInteger i=0;i<200;i++){
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(100 + i, 100, 5, 5)];
        [view1 setBackgroundColor:[UIColor redColor]];
        UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(100 + i, 300, 5, 5)];
        [view2 setBackgroundColor:[UIColor redColor]];
        view1.layer.cornerRadius = 2.5;
        view2.layer.cornerRadius = 2.5;
        [self.view addSubview:view1];
        [self.view addSubview:view2];
        
        
        
        UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(100, 100 + i, 5, 5)];
        [view3 setBackgroundColor:[UIColor redColor]];
        UIView * view4 = [[UIView alloc]initWithFrame:CGRectMake(300 , 300 - i, 5, 5)];
        [view4 setBackgroundColor:[UIColor redColor]];
        view3.layer.cornerRadius = 2.5;
        view4.layer.cornerRadius = 2.5;
        [self.view addSubview:view3];
        [self.view addSubview:view4];
    }
}
- (void)createAnimationView{
    self.animationView = [[UIView alloc]init];
    CGRect frame = self.animationView.frame;
    frame.size = CGSizeMake(40, 40);
    self.animationView.frame = frame;
//    self.animationView.layer.cornerRadius = 20;
    [self.animationView setCenter:self.view.center];
    [self.animationView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.animationView];
}

- (void)createTitleButtons{
    for (NSInteger i=0; i<self.titleNameArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:[self buttonsSetPositionAtIndex:i]];
        [button setTag:i+2000];
        [button addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.titleNameArray[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
}
- (void)buttonsClick:(UIButton *)button{
    switch (button.tag) {
        case 2000:
            [self pointSetAnimation];
            break;
        case 2001:
            [self pathAnimation];
            break;
        case 2002:
            [self trembleAnimation];
            break;
        
            
        default:
            break;
    }
}

#pragma mark layout -------->

- (CGRect)buttonsSetPositionAtIndex:(NSInteger)index{
    
    NSInteger margin = 8;
    NSInteger count = 3;
    NSInteger buttonWidth = ([[UIScreen mainScreen] bounds].size.width - (count+1) * margin) / count;
    NSInteger buttonHeight = 40;
    NSInteger marginLeftTotal = margin + index * (margin + buttonWidth);
    NSInteger marginTopTotal = [[UIScreen mainScreen] bounds].size.height - 64;
    
    return CGRectMake(marginLeftTotal, marginTopTotal, buttonWidth, buttonHeight);
}

#pragma mark animation------>

- (void)pointSetAnimation{
    NSLog(@"point set");
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startPoint = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *startPoint1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, 84)];
    NSValue *startPoint2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint3 = [NSValue valueWithCGPoint:CGPointMake(20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint4 = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *stopPoint = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    
    animation.values = [NSArray arrayWithObjects:startPoint,startPoint1,startPoint2,startPoint3,startPoint4,stopPoint, nil];
    animation.duration = 6.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    [self.animationView.layer addAnimation:animation forKey:@"pointSet"];
}

- (void)pathAnimation{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    animation.path = path.CGPath;
    animation.duration = 6.0f;
    [self.animationView.layer addAnimation:animation forKey:@"path"];
}
- (void)trembleAnimation{
    NSLog(@"tremble");
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue * value1 = [NSNumber numberWithFloat:-M_PI/180 *50];
    NSValue * value2 = [NSNumber numberWithFloat:M_PI/180 *50];
    NSValue * value3 = [NSNumber numberWithFloat:-M_PI/180 *50];
    animation.values = @[value1,value2,value3];
    animation.repeatCount = MAXFLOAT;
    [self.animationView.layer addAnimation:animation forKey:@"tremble"];
}

#define mark ------>delegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画");
}

@end
