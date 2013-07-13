# ios-cabin
my collection of ios utils.

# PagedImageScrollView:
* swipe fingers to left or right can change the image
* when you click the little dot at the right corner, you also can switch the image page by page.
* It is more productive because you can use 3-5 lines of code to finish the same function that you used to complete using almost 80-100 lines.

* Import: It is not a real system protogenetic(原生的) UIScrollView, in fact it is a UIView that contains UIScrollView and UIPageControl.
* requirement: iOS >= 5.0

# PagedImageScrollView Usaeg:
after importing "PagedImageScrollView.h",  place this code in ViewDidLoad method of your viewcontroller.

    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [pageScrollView setScrollViewContents:@[[UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"], [UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"]]];
    [self.view addSubview:pageScrollView];
