//
//  JXBarChartView.h
//  JXBarChartViewExample
//
//  Created by jianpx on 7/18/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXBarChartView : UIView
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic) float maxValue;
@property (nonatomic, strong) NSMutableArray *textIndicators;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) float barHeight;
@property (nonatomic) float barMaxWidth;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGGradientRef gradient;

- (id)initWithFrame:(CGRect)frame
         startPoint:(CGPoint)startPoint
             values:(NSMutableArray *)values
           maxValue:(float)maxValue
textIndicators:(NSMutableArray *)textIndicators
          textColor:(UIColor *)textColor
          barHeight:(float)barHeight
        barMaxWidth:(float)barMaxWidth
           gradient:(CGGradientRef)gradient;

@end
