//
//  PointBezierPathView.h
//  HW_CoreAnimation
//
//  Created by Alexander on 30.04.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAMediaTimingFunction;

@interface PointBezierPathView : UIView

// Call to get the current bezier path.
- (CGPathRef)bezierPath;

@end
