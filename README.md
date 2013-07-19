# ios-cabin
my collection of ios utils.

# PagedImageScrollView
* swipe fingers to left or right can change the image
* when you click the little dot at the right corner, you also can switch the image page by page.
* It is more productive because you can use 3-5 lines of code to finish the same function that you used to complete using almost 80-100 lines.

* Import: It is not a real system protogenetic(原生的) UIScrollView, in fact it is a UIView that contains UIScrollView and UIPageControl.
* requirement: iOS >= 5.0

# PagedImageScrollView Usage
after importing "PagedImageScrollView.h",  place this code in ViewDidLoad method of your viewcontroller.

    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [pageScrollView setScrollViewContents:@[[UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"], [UIImage imageNamed:@"xyq.jpeg"], [UIImage imageNamed:@"x2.jpeg"]]];
    //easily setting pagecontrol pos, see PageControlPosition defination in PagedImageScrollView.h
    pageScrollView.pageControlPos = PageControlPositionCenterBottom;
    [self.view addSubview:pageScrollView];


# JXBarChartView
* generate horizontal bar chart with text indicator on the left of bar and digit indicator on the right of bar, and the bar is drawn with gradient(渐变), so it is cooler than immutable color

# JXBarChartView Usage
after import "JXBarChartView.h",  place this code in ViewDidLoad method of your viewcontroller.

    [super viewDidLoad];
    NSMutableArray *textIndicators = [[NSMutableArray alloc] initWithObjects:@"标签1", @"标签2", @"标签3", @"标签4", @"标签5", nil];
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@0, @5, @10, @3, @7, nil];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    JXBarChartView *barChartView = [[JXBarChartView alloc] initWithFrame:frame
                                                              startPoint:CGPointMake(20, 20)
                                                                  values:values maxValue:10
                                                          textIndicators:textIndicators
                                                               textColor:[UIColor orangeColor]
                                                               barHeight:20
                                                             barMaxWidth:150
                                                                gradient:nil];
    [self.view addSubview:barChartView];

