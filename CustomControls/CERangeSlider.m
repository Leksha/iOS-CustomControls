//
//  CERangeSlider.m
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-05.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "CERangeSlider.h"
#import "QuartzCore/QuartzCore.h"
#import "CERangeSliderKnobLayer.h"
#import "CERangeSliderTrackLayer.h"

#define BOUND(VALUE, UPPER, LOWER)	MIN(MAX(VALUE, LOWER), UPPER)

@implementation CERangeSlider
{
    CERangeSliderKnobLayer *upperKnobLayer;
    CERangeSliderKnobLayer *lowerKnobLayer;
    CERangeSliderTrackLayer *trackLayer;
    
    float knobWidth;
    float useableTrackLength;
    CGPoint previousTouchPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _minimumValue = 0;
        _maximumValue = 10;
        _lowerValue = 1.0;
        _upperValue = 9.0;
        
        // Customize the slider
        _trackHighlighColour = [UIColor colorWithRed:0.0 green:0.45 blue:0.94 alpha:1.0];
        _trackColour = [UIColor colorWithWhite:0.9 alpha:1.0];
        _knobColour = [UIColor whiteColor];
        _curvaceousness = 1.0;
        
        trackLayer = [CERangeSliderTrackLayer layer];
        trackLayer.slider = self;
        [self.layer addSublayer:trackLayer];
        
        upperKnobLayer = [CERangeSliderKnobLayer layer];
        upperKnobLayer.slider = self;
        [self.layer addSublayer:upperKnobLayer];
        
        lowerKnobLayer = [CERangeSliderKnobLayer layer];
        lowerKnobLayer.slider = self;
        [self.layer addSublayer:lowerKnobLayer];
        
        [self setLayerFrames];
    }
    return self;
}

- (void) setLayerFrames {
    trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [trackLayer setNeedsDisplay];
    
    knobWidth = self.bounds.size.height;
    useableTrackLength = self.bounds.size.width - knobWidth;
    
    float upperKnobCenter = [self positionForValue:_upperValue];
    upperKnobLayer.frame = CGRectMake(upperKnobCenter - knobWidth/2, 0, knobWidth, knobWidth);
    
    float lowerKnobCenter = [self positionForValue:_lowerValue];
    lowerKnobLayer.frame = CGRectMake(lowerKnobCenter - knobWidth/2, 0, knobWidth, knobWidth);
    
    [upperKnobLayer setNeedsDisplay];
    [lowerKnobLayer setNeedsDisplay];
}

- (float) positionForValue:(float)value {
    float xStartingPoint = value - _minimumValue;
    float trackLength = _maximumValue - _minimumValue;
    float knobRadius = knobWidth / 2;
    
    return (useableTrackLength * (xStartingPoint / trackLength)) + knobRadius;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    previousTouchPoint = [touch locationInView:self];
    
    // hit test the knob layers
    if (CGRectContainsPoint(lowerKnobLayer.frame, previousTouchPoint)) {
        lowerKnobLayer.highlighted = YES;
        [lowerKnobLayer setNeedsDisplay];
    } else if (CGRectContainsPoint(upperKnobLayer.frame, previousTouchPoint)) {
        upperKnobLayer.highlighted = YES;
        [upperKnobLayer setNeedsDisplay];
    }
    
    return upperKnobLayer.highlighted || lowerKnobLayer.highlighted;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1. determine by how much the user has dragged
    float delta = touchPoint.x - previousTouchPoint.x;
    float valueDelta = (_maximumValue - _minimumValue) * (delta / useableTrackLength);
    
    previousTouchPoint = touchPoint;
    
    // 2. update the values
    if (lowerKnobLayer.highlighted) {
        _lowerValue += valueDelta;
        _lowerValue = BOUND(_lowerValue, _upperValue, _minimumValue);
    }
    
    if (upperKnobLayer.highlighted) {
        _upperValue += valueDelta;
        _upperValue = BOUND(_upperValue, _maximumValue, _lowerValue);
    }
    // 3. Update the UI state
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    lowerKnobLayer.highlighted = upperKnobLayer.highlighted = NO;
    [lowerKnobLayer setNeedsDisplay];
    [upperKnobLayer setNeedsDisplay];
}

@end
