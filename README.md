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

# RouteTableManager
* flaw: destination property can not display netmask, for example, ```netstat -r``` sometimes would display ```10.1.1/32```. If you have good idea to implement the netmask, please let me know and send me a pull request.
* sources files are:RouteTableManager.h/m and RouteRecord.h/m
* import "RouteTableManager.h"
* ```[RouteTableManager getAllRoutes]``` to get all routes, every route record's property is in RouteRecord.h
* ```[RouteTableManager formatRouteTable]``` can get route table string like unix command ```netstat -r```, e.g.

```
Destination       Gateway            Flags     Refs   Use     Mtu     Netif   Expire       
default           10.250.174.1       UGSc      189    0       1500    en0     0            
10.62.0.0         10.62.2.35         UGSc      11     0       1500    tun0    0            
10.62.2.35        10.62.2.35         UH        2      0       1500    tun0    0            
10.63.2.0         10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.4.0         10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.15.48       10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.15.64       10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.15.80       10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.15.160      10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.15.176      10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.23.0        10.62.0.1          UGSc      1      0       1500    tun0    0            
10.63.58.0        10.62.0.1          UGSc      1      0       1500    tun0    0            
10.250.174.0      link #5            UCS       2      0       1500    en0     1472454140   
10.250.174.1      link #5            UCS       2      0       1500    en0     1472454140   
10.250.174.1      0.13.19.aa.42.bf   UHLWIir   196    29      1500    en0     1472460068   
10.250.174.135    link #5            UCS       2      0       1500    en0     1472454140   
10.250.174.135    b8.e8.56.6.be.38   UHLWIi    1      1       16384   lo0     0            
10.250.175.255    link #5            UHLWbI    1      18      1500    en0     1472454143   
113.108.224.252   10.250.174.1       UGSc      1      0       1500    en0     0            
113.108.224.253   10.62.0.1          UGSc      1      0       1500    tun0    0            
123.58.165.249    10.250.174.1       UGSc      1      0       1500    en0     0            
123.58.173.50     10.250.174.1       UGSc      2      0       1500    en0     0            
123.58.173.171    10.250.174.1       UGSc      1      0       1500    en0     0            
123.58.175.212    10.250.174.1       UGSc      1      0       1500    en0     0            
127.0.0.0         127.0.0.1          UCS       1      0       16384   lo0     0            
127.0.0.1         127.0.0.1          UH        9      32816   16384   lo0     0            
169.254.0.0       link #5            UCS       1      0       1500    en0     1472454140   
218.107.55.89     10.250.174.1       UGSc      1      0       1500    en0     0            
224.0.0.0         link #5            UCSm      2      0       1500    en0     1472454140   
224.0.0.251       1.0.5e.0.0.fb      UHLWIm    1      0       1500    en0     0            
255.255.255.255   link #5            UCS       1      0       1500    en0     1472454140  
```
