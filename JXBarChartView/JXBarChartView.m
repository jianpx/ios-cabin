//
//  JXBarChartView.m
//  JXBarChartViewExample
//
//  Created by jianpx on 7/18/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "JXBarChartView.h"

@interface JXBarChartView()
@property (nonatomic) CGContextRef context;
@property (nonatomic, strong) NSMutableArray *textIndicatorsLabels;
@property (nonatomic, strong) NSMutableArray *digitIndicatorsLabels;
@end

@implementation JXBarChartView


- (id)initWithFrame:(CGRect)frame
         startPoint:(CGPoint)startPoint
             values:(NSMutableArray *)values
           maxValue:(float)maxValue
     textIndicators:(NSMutableArray *)textIndicators
          textColor:(UIColor *)textColor
          barHeight:(float)barHeight
        barMaxWidth:(float)barMaxWidth
           gradient:(CGGradientRef)gradient
{
    self = [super initWithFrame:frame];
    if (self) {
        _values = values;
        _maxValue = maxValue;
        _textIndicatorsLabels = [[NSMutableArray alloc] initWithCapacity:[values count]];
        _digitIndicatorsLabels = [[NSMutableArray alloc] initWithCapacity:[values count]];
        _textIndicators = textIndicators;
        _startPoint = startPoint;
        _textColor = textColor ? textColor : [UIColor orangeColor];
        _barHeight = barHeight;
        _barMaxWidth = barMaxWidth;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //blue gradient
        CGFloat locations[] = {0.0, 0.5, 1.0};
        CGFloat colorComponents[] = {
            0.254, 0.599, 0.82, 1.0, //red, green, blue, alpha
            0.192, 0.525, 0.75, 1.0,
            0.096, 0.415, 0.686, 1.0
        };
        size_t count = 3;
        CGGradientRef defaultGradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, count);
        _gradient = gradient ?  gradient : defaultGradient;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setLabelDefaults:(UILabel *)label
{
    label.textColor = self.textColor;
    [label setTextAlignment:NSTextAlignmentLeft];
    label.adjustsFontSizeToFitWidth = YES;
    label.adjustsLetterSpacingToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
}

- (void)drawRectangle:(CGRect)rect context:(CGContextRef)context
{
    CGContextSaveGState(self.context);
    CGContextAddRect(self.context, rect);
    CGContextClipToRect(self.context, rect);
    CGPoint startPoint = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGContextDrawLinearGradient(self.context, self.gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(self.context);
}

- (void)drawRect:(CGRect)rect
{
    self.context = UIGraphicsGetCurrentContext();
    int count = [self.values count];
    float startx = self.startPoint.x;
    float starty = self.startPoint.y;
    float barMargin = 22;
    float marginOfBarAndDigit = 2;
    float marginOfTextAndBar = 8;
    float digitWidth = 20;
    float textWidth = 70;
    for (int i = 0; i < count; i++) {
        //handle textlabel
        float textMargin_y = (i * (self.barHeight + barMargin)) + starty;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(startx, textMargin_y, textWidth, self.barHeight)];
        textLabel.text = self.textIndicators[i];
        [self setLabelDefaults:textLabel];
        @try {
            UILabel *originalTextLabel = self.textIndicatorsLabels[i];
            if (originalTextLabel) {
                [originalTextLabel removeFromSuperview];
            }
        }
        @catch (NSException *exception) {
            [self.textIndicatorsLabels insertObject:textLabel atIndex:i];
        }
        [self addSubview:textLabel];
        
        //handle bar
        float barMargin_y = (i * (self.barHeight + barMargin)) + starty;
        float v = [self.values[i] floatValue] <= self.maxValue ? [self.values[i] floatValue]: self.maxValue;
        float rate = v / self.maxValue;
        float barWidth = rate * self.barMaxWidth;
        CGRect barFrame = CGRectMake(startx + textWidth + marginOfTextAndBar, barMargin_y, barWidth, self.barHeight);
        [self drawRectangle:barFrame context:self.context];
        //handle digitlabel
        UILabel *digitLabel = [[UILabel alloc] initWithFrame:CGRectMake(barFrame.origin.x + barFrame.size.width + marginOfBarAndDigit, barFrame.origin.y, digitWidth, barFrame.size.height)];
        digitLabel.text = [self.values[i] stringValue];
        [self setLabelDefaults:digitLabel];
        @try {
            UILabel *originalDigitLabel = self.digitIndicatorsLabels[i];
            if (originalDigitLabel) {
                [originalDigitLabel removeFromSuperview];
            }
        }
        @catch (NSException *exception) {
            [self.digitIndicatorsLabels insertObject:digitLabel atIndex:i];
        }
        [self addSubview:digitLabel];
    }
}

- (void)setValues:(NSMutableArray *)values
{
    for (int i = 0; i < [values count]; i++) {
        _values[i] = values[i];
    }
    [self setNeedsDisplay];
}

@end
