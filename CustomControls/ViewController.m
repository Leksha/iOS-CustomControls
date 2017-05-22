//
//  ViewController.m
//  CustomControls
//
//  Created by Leksha Ramdenee on 2016-12-05.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "ViewController.h"
#import "CERangeSlider.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CERangeSlider *_rangeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 50;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin*2, 30);
    
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    
    [self.view addSubview:_rangeSlider];
    
    [_rangeSlider addTarget:self
                     action:@selector(slideValueChanged:)
            forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)slideValueChanged:(id)control {
    NSLog(@"Slider value changed: (%.2f, %.2f)",
          _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

@end
