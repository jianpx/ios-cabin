# Features:
* generate horizontal bar chart with text indicator on the left of bar and digit indicator on the right of bar.
* the bar is drawn with gradient(渐变), so it is cooler than immutable color
* using iOS core graphics

# ScreenShot
![BarChartView Image](https://www.dropbox.com/s/yj2alwwlxizhsnr/barchart.png "BarChartView Image")

# Requirement
* iOS >= 5.0

# Memo
* the name : JXBarChartView , JX is the combination of my first letter of first name and the first letter of my girl friend's first name. ^.^

# Usage:
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

# What can you learn from
* how to draw rectangle and using gradient color to fill it, using core graphics
* learn concept of context(canvas in the web).
