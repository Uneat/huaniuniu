//
//  OfficialViewController.m
//  AnimationDemo
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "OfficialViewController.h"

@interface OfficialViewController ()
@property (nonatomic, strong)UIView *animationView1;
@property (nonatomic, strong)UIView *animationView2;
@property (nonatomic, strong)UIView *animationView3;
@property (nonatomic, strong)UIView *animationView4;
@property (nonatomic, strong)UIView *animationView5;
@property (nonatomic, strong)NSArray * titleNameArray;

@end

@implementation OfficialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self createAnimationView1];
    [self createAnimationView2];
    [self createAnimationView3];
    [self createAnimationView4];
    [self createAnimationView5];
    [self createTitleButtons];
}
- (NSArray *)titleNameArray{
    return [NSArray arrayWithObjects:@"移动",@"旋转",@"综合",@"缩放", nil];
}
- (void)createAnimationView1{
    self.animationView1 = [[UIView alloc]init];
    CGRect frame = self.animationView1.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView1.frame = frame;
    self.animationView1.center = self.view.center;
    [self.animationView1 setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView1];
    
}
- (void)createAnimationView2{
    self.animationView2 = [[UIView alloc]init];
    CGRect frame = self.animationView2.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView2.frame = frame;
    self.animationView2.center = self.view.center;
    [self.animationView2 setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView2];
    
}
- (void)createAnimationView3{
    self.animationView3 = [[UIView alloc]init];
    CGRect frame = self.animationView3.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView3.frame = frame;
    self.animationView3.center = self.view.center;
    [self.animationView3 setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView3];
    
}
- (void)createAnimationView4{
    self.animationView4 = [[UIView alloc]init];
    CGRect frame = self.animationView4.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView4.frame = frame;
    self.animationView4.center = self.view.center;
    [self.animationView4 setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView4];
    
}
- (void)createAnimationView5{
    self.animationView5 = [[UIView alloc]init];
    CGRect frame = self.animationView5.frame;
    frame.size = CGSizeMake(80, 80);
    self.animationView5.frame = frame;
    self.animationView5.center = self.view.center;
    [self.animationView5 setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.animationView5];
    
}
- (void)createTitleButtons{
    for (NSInteger i=0; i<self.titleNameArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:[self buttonsSetPositionAtIndex:i]];
        [button setTag:i+4000];
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
        case 4000:
            [self moveAnimation];
            break;
        case 4001:
            [self rotateAnimation];
            break;
        case 4002:
            [self combinationAnimation];
            break;
        case 4003:
            [self scaleAnimation];
            break;
            
            
        default:
            break;
    }
}

- (CGRect)buttonsSetPositionAtIndex:(NSInteger)index{
    
    NSInteger margin = 8;
    NSInteger count = 4;
    NSInteger buttonWidth = ([[UIScreen mainScreen] bounds].size.width - (count+1) * margin) / count;
    NSInteger buttonHeight = 40;
    NSInteger marginLeftTotal = margin + index * (margin + buttonWidth);
    NSInteger marginTopTotal = [[UIScreen mainScreen] bounds].size.height - 64;
    
    return CGRectMake(marginLeftTotal, marginTopTotal, buttonWidth, buttonHeight);
}

- (void)moveAnimation{
    self.animationView1.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView1.transform = CGAffineTransformMakeTranslation(-120, -180);
        
//        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(-120, -180);
//
//        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
//        self.animationView1.transform = transform2;

    }];
    self.animationView2.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView2.transform = CGAffineTransformMakeTranslation(-120, 180);
    }];
    self.animationView3.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView3.transform = CGAffineTransformMakeTranslation(120, -180);
    }];
    self.animationView4.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView4.transform = CGAffineTransformMakeTranslation(120, 180);
    }];
}

- (void)rotateAnimation{
    self.animationView1.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView1.transform = CGAffineTransformMakeRotation(M_PI );
    }];
    
    self.animationView2.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView2.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    self.animationView3.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView3.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    self.animationView4.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView4.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
- (void)combinationAnimation{
//    self.animationView1.transform = CGAffineTransformIdentity;
//    [UIView animateWithDuration:2.0f animations:^{
//        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
//        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
//        self.animationView1.transform = CGAffineTransformTranslate(transform2, 100, 100);
//    }];
    
    
    self.animationView1.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
//        self.animationView1.transform = CGAffineTransformMakeTranslation(-120, -180);
        
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(-140, -200);
        
        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
         CGAffineTransform transform = CGAffineTransformScale(transform2, 0.5, 0.5);
        self.animationView1.transform = transform;
        
    }];
    self.animationView2.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(-140, 200);
        
        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
         CGAffineTransform transform = CGAffineTransformScale(transform2, 0.5, 0.5);
        self.animationView2.transform = transform;
    }];
    self.animationView3.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(140, -200);
        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
         CGAffineTransform transform = CGAffineTransformScale(transform2, 0.5, 0.5);
        
        self.animationView3.transform = transform;
        
        
    }];
    self.animationView4.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(140, 200);
        CGAffineTransform transform2 = CGAffineTransformRotate(transform1, M_PI);
        CGAffineTransform transform = CGAffineTransformScale(transform2, 0.5, 0.5);
        self.animationView4.transform = transform;
    }];
}
- (void)scaleAnimation{
    self.animationView1.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView1.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(4, 4));
    }];
    
    self.animationView2.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView2.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(4, 4));
    }];
    
    self.animationView3.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView3.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(4, 4));
    }];
    
    self.animationView4.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2.0f animations:^{
        self.animationView4.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(4, 4));
    }];
}



@end
