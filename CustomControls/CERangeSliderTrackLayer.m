//
//  CERangeSliderTrackLayer.m
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-06.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "CERangeSliderTrackLayer.h"
#import "CERangeSlider.h"

@implementation CERangeSliderTrackLayer

- (void)drawInContext:(CGContextRef)ctx {
    // clip
    float cornerRadius = self.bounds.size.height * self.slider.curvaceousness / 2.0;
    UIBezierPath *switchOutline = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextClip(ctx);
    
    // 1) fill the track
    CGContextSetFillColorWithColor(ctx, self.slider.trackColour.CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextFillPath(ctx);
    
    // 2) Fill the highlighted range
    CGContextSetFillColorWithColor(ctx, self.slider.trackHighlighColour.CGColor);
    float lower = [self.slider positionForValue:self.slider.lowerValue];
    float upper = [self.slider positionForValue:self.slider.upperValue];
    CGContextFillRect(ctx, CGRectMake(lower, 0, upper - lower, self.bounds.size.height));
    
    // 3) Add a highlight over the track
    CGRect highlight = CGRectMake(cornerRadius/2,
                                  self.bounds.size.height/2,
                                  self.bounds.size.width - cornerRadius,
                                  self.bounds.size.height/2);
    UIBezierPath *highlightPath = [UIBezierPath bezierPathWithRoundedRect:highlight
                                                             cornerRadius:highlight.size.height * self.slider.curvaceousness / 2.0];
    CGContextAddPath(ctx, highlightPath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1.0 alpha:0.4].CGColor);
    CGContextFillPath(ctx);
    
    // 4) Inner shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.0), 3.0, [UIColor grayColor].CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextStrokePath(ctx);
    
    // 5) Outline the track
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);

}

@end
