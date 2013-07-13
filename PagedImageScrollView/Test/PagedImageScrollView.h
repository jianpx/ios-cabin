//
//  PagedImageScrollView.h
//  Test
//
//  Created by jianpx on 7/11/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedImageScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

- (void)setScrollViewContents: (NSArray *)images;
@end
