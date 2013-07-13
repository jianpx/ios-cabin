//
//  ViewController.m
//  Test
//
//  Created by jianpx on 7/10/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "ViewController.h"
#import "PagedImageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //sample invoke code. 3 lines!
    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [pageScrollView setScrollViewContents:@[[UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"], [UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"]]];
    [self.view addSubview:pageScrollView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
