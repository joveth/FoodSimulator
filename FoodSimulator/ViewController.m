//
//  ViewController.m
//  FoodSimulator
//
//  Created by Shuwei on 15/11/30.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *cookFoods;
    NSMutableArray *foodList;
    MBProgressHUD *HUD;
    CGFloat width;
    UIView *topView;
    UIScrollView *scroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"食谱模拟器";
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    cookFoods = [[NSMutableArray alloc] init];
    width = self.view.frame.size.width/4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 66)];
    UIImageView *m1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 2, width, 60)];
    m1.image=[UIImage imageNamed:@"background"];
    [topView addSubview:m1];
    
    UIImageView *m2 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 2, width, 60)];
    m2.image=[UIImage imageNamed:@"background"];
    [topView addSubview:m2];
    
    
    UIImageView *m3 = [[UIImageView alloc] initWithFrame:CGRectMake(122, 2, width, 60)];
    m3.image=[UIImage imageNamed:@"background"];
    [topView addSubview:m3];
    
    UIImageView *m4 = [[UIImageView alloc] initWithFrame:CGRectMake(183, 2, width, 60)];
    m4.image=[UIImage imageNamed:@"background"];
    [topView addSubview:m4];
    
    scroll = [[UIScrollView alloc] init];
    scroll.frame = CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-130);
    scroll.backgroundColor = [Common colorWithHexString:@"e0e0e0"];
    
    foodList = [[[FoodBean alloc] init] getFood];
     NSInteger size =[foodList count];
    CGFloat x,y;
    for(int i=0;i<size;i++){
        FoodBean *bean = [foodList objectAtIndex:i];
        x = i%4*width;
        y=i/4*60;
        UIView *b6 = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 60)];
        b6.backgroundColor=[UIColor whiteColor];
        b6.layer.borderWidth=0.5;
        b6.layer.borderColor=[Common colorWithHexString:@"e0e0e0"].CGColor;
        UIImageView *i6 = [[UIImageView alloc] initWithFrame:CGRectMake( (width-35)/2, 5, 35, 35)];
        i6.image = [UIImage imageNamed:bean.img];
        UILabel *l6 = [[UILabel alloc] initWithFrame:CGRectMake(1, 40, width-2, 20)];
        l6.font=[UIFont systemFontOfSize:16];
        l6.textColor=[UIColor blackColor];
        l6.textAlignment=NSTextAlignmentCenter;
        l6.text=bean.name;
        [b6 addSubview:i6];
        [b6 addSubview:l6];
        b6.tag=(i+1);
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
        tap6.cancelsTouchesInView=NO;
        tap6.delegate = self;
        [b6 addGestureRecognizer:tap6];
        [scroll addSubview:b6];
    }
    
    NSInteger line = 0;
    if(size%4==0){
        line=size/4;
    }else{
        line=size/4+1;
    }
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, 60*line+10);
    [self.view addSubview:scroll];
    [self.view addSubview:topView];
    [HUD hide:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)handler :(UITapGestureRecognizer *)sender{
    NSLog(@"tag=%ld",sender.view.tag);

}

-(void)addToCook{
    if([cookFoods count]==4){
        return;
    }else if([cookFoods count]==3){
        
    }
    
}

@end
