//
//  PagedImageScrollView.m
//  Created by jianpx on 7/11/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "PagedImageScrollView.h"

@interface PagedImageScrollView() <UIScrollViewDelegate>
@property (nonatomic) BOOL pageControlIsChangingPage;
@end

@implementation PagedImageScrollView


#define PAGECONTROL_DOT_WIDTH 20
#define PAGECONTROL_HEIGHT 36

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControlIsChangingPage = NO;
        [self setDefaults];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        self.scrollView.delegate = self;
    }
    return self;
}


- (void)setDefaults
{
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.hidesForSinglePage = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}


- (void)setPageControlFrame: (NSInteger)numberOfPages
{
    CGFloat width = PAGECONTROL_DOT_WIDTH * numberOfPages;
    //set to right corner.
    self.pageControl.frame = CGRectMake(self.scrollView.frame.size.width - width, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT, width, PAGECONTROL_HEIGHT);
}

- (void)setScrollViewContents: (NSArray *)images
{
    //remove original subviews first.
    for (UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    if (images.count <= 0) {
        self.pageControl.numberOfPages = 0;
        return;
    }
    //important to set contentSize otherwise will not scroll!
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count, self.scrollView.frame.size.height);
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        [imageView setImage:images[i]];
        [self.scrollView addSubview:imageView];
    }
    self.pageControl.numberOfPages = images.count;
    [self setPageControlFrame:self.pageControl.numberOfPages];
}

- (void)changePage:(UIPageControl *)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    //scrollRectToVisible will fire scrollViewDidEndDecelerating event.
    [self.scrollView scrollRectToVisible:frame animated:YES];
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    self.pageControlIsChangingPage = YES;
}

#pragma scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.pageControlIsChangingPage) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    //switch page at 50% across
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

//optimize steps
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControlIsChangingPage = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.pageControlIsChangingPage = NO;
}

@end
