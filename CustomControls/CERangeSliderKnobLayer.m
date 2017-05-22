//
//  CERangeSliderKnobLayer.m
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-05.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "CERangeSliderKnobLayer.h"
#import "CERangeSlider.h"

@implementation CERangeSliderKnobLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGRect knobFrame = CGRectInset(self.bounds, 2.0, 2.0);
    UIBezierPath *knobPath = [UIBezierPath bezierPathWithRoundedRect:knobFrame
                                                        cornerRadius:knobFrame.size.height * self.slider.curvaceousness / 2.0];
    
    // 1) Fill with a subtle shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(ctx, self.slider.knobColour.CGColor);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextFillPath(ctx);
    
    // 2) Outline
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextStrokePath(ctx);

    // 3) Inner gradient
    CGRect rect = CGRectInset(knobFrame, 2.0, 2.0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:rect.size.height * self.slider.curvaceousness / 2.0];
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 0.0, 0.0, 0.15, // Start color
        0.0, 0.0, 0.0, 0.05 }; // End color
    
    myColorSpace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, locations, num_locations);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, clipPath.CGPath);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorSpace);
    CGContextRestoreGState(ctx);
    
    // 4) highlight
    if (self.highlighted) {
        // Fill
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextFillPath(ctx);
    }
}

@end
