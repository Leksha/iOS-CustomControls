//
//  CERangeSliderKnobLayer.h
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-05.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class CERangeSlider;

@interface CERangeSliderKnobLayer : CALayer

@property BOOL highlighted;
@property (weak) CERangeSlider *slider;

@end
