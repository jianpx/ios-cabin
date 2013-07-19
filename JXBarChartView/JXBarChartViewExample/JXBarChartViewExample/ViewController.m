//
//  ViewController.m
//  JXBarChartViewExample
//
//  Created by jianpx on 7/18/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "ViewController.h"
#import "JXBarChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *textIndicators = [[NSMutableArray alloc] initWithObjects:@"标签1", @"标签2", @"标签3", @"标签4", @"标签5", nil];
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@0, @5, @10, @3, @7, nil];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    JXBarChartView *barChartView = [[JXBarChartView alloc] initWithFrame:frame
                                                              startPoint:CGPointMake(20, 20)
                                                                  values:values maxValue:10
                                                          textIndicators:textIndicators
                                                               textColor:[UIColor orangeColor]
                                                               barHeight:30
                                                             barMaxWidth:200
                                                                gradient:nil];
    [self.view addSubview:barChartView];
}

@end
