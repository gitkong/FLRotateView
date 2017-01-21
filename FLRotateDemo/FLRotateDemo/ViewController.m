//
//  ViewController.m
//  FLRotateDemo
//
//  Created by clarence on 17/1/19.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Model.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define fl_x 0
@interface ViewController ()
@property (nonatomic,weak)UIView *rotateView;
@property (nonatomic,assign)BOOL flag;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"statusBarOrientation"];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 1)];
    line.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:line];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, fl_x, screenWidth, 200)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [view addGestureRecognizer:tap];
    self.rotateView = view;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, screenHeight - 200)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"gitkong";
    label.center = view.center;
    [view addSubview:label];
    view.backgroundColor = [UIColor purpleColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 200, 30)];
    textField.placeholder = @"hello gitkong";
//    [view addSubview:textField];
    
    [self.view addSubview:view];
    [UIApplication fl_printAllProperties];
}

- (void)ro:(UIView *)rotateView{
    self.navigationController.navigationBar.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        UIStatusBar *statusBar = [[UIApplication sharedApplication] valueForKey:@"_statusBar"];
        [self fl_setFrame:statusBar];
        [self fl_setView:rotateView];
        [self fl_setNav:self.navigationController.navigationBar];
    } completion:^(BOOL finished) {
//        CGRectMake(screenWidth - 64, 0, 64,screenHeight)
        // 不能使用NavigationBarHidden
        [UIView animateWithDuration:0.5 animations:^{
            [self.rotateView layoutIfNeeded];
            self.navigationController.navigationBar.hidden = NO;
        }];

    }];
//    [NSThread sleepForTimeInterval:1.0];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)reset{
    self.navigationController.navigationBar.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        UIStatusBar *statusBar = [[UIApplication sharedApplication] valueForKey:@"_statusBar"];
        [self fl_resetFrame:statusBar];
        [self fl_resetView:self.rotateView];
        [self fl_resetNav:self.navigationController.navigationBar];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.hidden = NO;
        }];
        
    }];
}

- (void)fl_setFrame:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (M_PI_2);
    // 已经选择了，那么xy值就调转了
    view.transform = CGAffineTransformTranslate(view.transform, -(view.frame.origin.y - fl_x), 0);
    view.frame = CGRectMake(screenWidth - 20, 0, 20,screenHeight);
}

- (void)fl_setView:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (M_PI_2);
    // 已经选择了，那么xy值就调转了
    view.transform = CGAffineTransformTranslate(view.transform, -(view.frame.origin.y - fl_x), 0);
    view.frame = CGRectMake(0, 0, screenWidth,screenHeight);
}

- (void)fl_setNav:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (M_PI_2);
    // 已经选择了，那么xy值就调转了
    view.transform = CGAffineTransformTranslate(view.transform, -(view.frame.origin.y - fl_x), 0);
    view.frame = CGRectMake(screenWidth - 64, 0, screenHeight,screenHeight);
}

- (void)click{
    self.flag = !self.flag;
    if (self.flag) {
        [self ro:self.rotateView];
    }
    else{
        [self reset];
    }
    
    
}



- (void)fl_resetFrame:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (0);
    view.frame = CGRectMake(0, 0, screenWidth, 20);
}

- (void)fl_resetView:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (0);
    view.frame = CGRectMake(0, 0, screenWidth, 200);
}

- (void)fl_resetNav:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation (0);
    view.frame = CGRectMake(0, 0, screenWidth, 64);
}



@end
