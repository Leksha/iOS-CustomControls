//
//  CERangeSlider.h
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-05.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CERangeSlider : UIControl

@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@property (nonatomic) float upperValue;
@property (nonatomic) float lowerValue;

// Customize the slider look
@property (nonatomic) UIColor * trackColour;
@property (nonatomic) UIColor * trackHighlighColour;
@property (nonatomic) UIColor * knobColour;
@property (nonatomic) float curvaceousness;

- (float) positionForValue:(float)value;




@end
