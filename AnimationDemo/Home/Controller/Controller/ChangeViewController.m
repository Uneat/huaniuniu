//
//  ChangeViewController.m
//  AnimationDemo
//
//  Created by Orient on 2018/1/22.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()
@property (nonatomic, strong)UIView * animationView;
@property (nonatomic, strong)NSArray * titleNameArray;
@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self createAnimationView];
    [self createTitleButtons];
}
- (NSArray *)titleNameArray{
    return [NSArray arrayWithObjects:@"组合",@"队列", nil];
}
- (void)createAnimationView{
    self.animationView = [[UIView alloc]init];
    CGRect frame = self.animationView.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView.frame = frame;
    self.animationView.center = self.view.center;
    [self.animationView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView];
}
- (void)createTitleButtons{
    for (NSInteger i=0; i<self.titleNameArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:[self buttonsSetPositionAtIndex:i]];
        [button setTag:i+3000];
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
        case 3000:
            [self groupAnimation];
            break;
        case 3001:
            [self queueAnimation];
            break;
 
        default:
            break;
    }
}
#pragma mark layout -------->

- (CGRect)buttonsSetPositionAtIndex:(NSInteger)index{
    
    NSInteger margin = 8;
    NSInteger count = 2;
    NSInteger buttonWidth = ([[UIScreen mainScreen] bounds].size.width - (count+1) * margin) / count;
    NSInteger buttonHeight = 40;
    NSInteger marginLeftTotal = margin + index * (margin + buttonWidth);
    NSInteger marginTopTotal = [[UIScreen mainScreen] bounds].size.height - 64;
    
    return CGRectMake(marginLeftTotal, marginTopTotal, buttonWidth, buttonHeight);
}
#define mark ---->animation

- (void)groupAnimation{
    NSLog(@"group");
    //关键点位移
    CAKeyframeAnimation * animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startPoint = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *startPoint1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, 84)];
    NSValue *startPoint2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint3 = [NSValue valueWithCGPoint:CGPointMake(20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint4 = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *stopPoint = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    animation1.values = [NSArray arrayWithObjects:startPoint,startPoint1,startPoint2,startPoint3,startPoint4,stopPoint, nil];
    //缩放
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:0.5f];
    animation2.toValue = [NSNumber numberWithFloat:2.0f];
    //旋转
    CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation3.toValue = [NSNumber numberWithFloat:M_PI * 150];
    //透明
    CABasicAnimation * animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.toValue = [NSNumber numberWithFloat:1.0f];
    animation4.fromValue = [NSNumber numberWithFloat:0.2f];
    //变色
    CABasicAnimation * animation5 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation5.toValue = (id)[UIColor redColor].CGColor;
    
    //把动画组合
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:animation1,animation2,animation3,animation4,animation5, nil];
    groupAnimation.duration = 6.0f;
    
    [self.animationView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
}
- (void)queueAnimation{
    NSLog(@"queue");
//    dispatch_queue_t queue = dispatch_queue_create("com.privateQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        CAKeyframeAnimation * animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        NSValue *startPoint = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
//        NSValue *startPoint1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, 84)];
//        NSValue *startPoint2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, SCREEN_HEIGHT - 84)];
//        NSValue *startPoint3 = [NSValue valueWithCGPoint:CGPointMake(20, SCREEN_HEIGHT - 84)];
//        NSValue *startPoint4 = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
//        NSValue *stopPoint = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)];
//        animation1.duration = 6.0f;
//        animation1.values = [NSArray arrayWithObjects:startPoint,startPoint1,startPoint2,startPoint3,startPoint4,stopPoint, nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //需要保存上一次动画的状态的话加这两句
////            animation1.fillMode = kCAFillModeForwards;
////            animation1.removedOnCompletion = NO;
//            [self.animationView.layer addAnimation:animation1 forKey:@"position"];
//        });
//        sleep(6);
//        NSLog(@"1");
//    });
//    dispatch_async(queue, ^{
//        //缩放
//        CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        animation2.fromValue = [NSNumber numberWithFloat:0.5f];
//        animation2.toValue = [NSNumber numberWithFloat:2.0f];
//        animation2.duration = 6.0f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.animationView.layer addAnimation:animation2 forKey:@"scale"];
//
//        });
//        sleep(6);
//        NSLog(@"2");
//    });
//    dispatch_async(queue, ^{
//        CABasicAnimation * animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        animation4.toValue = [NSNumber numberWithFloat:1.0f];
//        animation4.fromValue = [NSNumber numberWithFloat:0.2f];
//        animation4.duration = 6.0f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.animationView.layer addAnimation:animation4 forKey:@"opacity"];
//        });
//        sleep(6);
//        NSLog(@"3");
//    });
//    dispatch_async(queue, ^{
//
//        CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        animation3.toValue = [NSNumber numberWithFloat:M_PI * 150];
//        animation3.duration = 6.0f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.animationView.layer addAnimation:animation3 forKey:@"transform"];
//        });
//        sleep(6);
//        NSLog(@"4");
//    });
//    dispatch_async(queue, ^{
//        CABasicAnimation * animation5 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//        animation5.toValue = (id)[UIColor redColor].CGColor;
//        animation5.duration = 6.0f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.animationView.layer addAnimation:animation5 forKey:@"backgroundColor"];
//        });
//        sleep(6);
//        NSLog(@"5");
//    });
    
    
    
    [self continuityAnimation];
    
}

- (void)continuityAnimation{
    
    CFTimeInterval startTime = CACurrentMediaTime();
    CAKeyframeAnimation * animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startPoint = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *startPoint1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, 84)];
    NSValue *startPoint2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH-20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint3 = [NSValue valueWithCGPoint:CGPointMake(20, SCREEN_HEIGHT - 84)];
    NSValue *startPoint4 = [NSValue valueWithCGPoint:CGPointMake(20, 84)];
    NSValue *stopPoint = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    animation1.duration = 2.0f;
    animation1.beginTime = startTime;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.values = [NSArray arrayWithObjects:startPoint,startPoint1,startPoint2,startPoint3,startPoint4,stopPoint, nil];
    [self.animationView.layer addAnimation:animation1 forKey:@"position"];
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:0.5f];
    animation2.toValue = [NSNumber numberWithFloat:2.0f];
    animation2.duration = 2.0f;
    animation2.beginTime = startTime + 2.0f;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    [self.animationView.layer addAnimation:animation2 forKey:@"scale"];
    
    CABasicAnimation * animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.toValue = [NSNumber numberWithFloat:1.0f];
    animation4.fromValue = [NSNumber numberWithFloat:0.2f];
    animation4.duration = 2.0f;
    animation4.beginTime = startTime + 4.0f;
    animation4.fillMode = kCAFillModeForwards;
    animation4.removedOnCompletion = NO;
    [self.animationView.layer addAnimation:animation4 forKey:@"opacity"];
    
    CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation3.toValue = [NSNumber numberWithFloat:M_PI * 150];
    animation3.duration = 2.0f;
    animation3.beginTime = startTime + 6.0f;
    animation3.fillMode = kCAFillModeForwards;
    animation3.removedOnCompletion = NO;
    [self.animationView.layer addAnimation:animation3 forKey:@"transform"];
    
    CABasicAnimation * animation5 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation5.toValue = (id)[UIColor redColor].CGColor;
    animation5.duration = 2.0f;
    animation5.beginTime = startTime + 8.0f;
    animation5.fillMode = kCAFillModeForwards;
    animation5.removedOnCompletion = NO;
    [self.animationView.layer addAnimation:animation5 forKey:@"backgroundColor"];
    
    
}


@end
