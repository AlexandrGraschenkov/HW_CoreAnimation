//
//  ViewController.m
//  HW_CoreAnimation
//
//  Created by Alexander on 30.04.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "PointBezierPathView.h"

@interface ViewController (){
    // store a reference so we can modify the title ("Animate", "Stop")
    
    BOOL _animating;
    CALayer *_layer;
}

@end

@implementation ViewController

static void *kBezierPathChangedContextKey = &kBezierPathChangedContextKey;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // This is the layer that will animate along the path when the user presses the "_animateButton".
    _layer = [CALayer layer];
    [_layer setContentsScale:[[UIScreen mainScreen] scale]];
    [_layer setContents:(__bridge id)[[UIImage imageNamed:@"body_point_act.png"] CGImage]];
    [_layer setBounds:CGRectMake(0.0, 0.0, 60.0, 60.0)];
}

- (IBAction)toggleAnimation:(id)sender
{
    if (_animating) { // currently animation... so stop.
        
        [CATransaction setCompletionBlock:^{
            [_layer removeAllAnimations];
            [_layer removeFromSuperlayer];
        }];
        [_layer setOpacity:0.0];
        
        [_barButton setTitle:@"GO"];
        _animating = NO;
    } else {  // not _animating... so start
        
        PointBezierPathView *pathView = (PointBezierPathView *)[self view];
        
        [[pathView layer] addSublayer:_layer];
        [_layer setOpacity:1.0];
        
        [self updateAnimationForPath:[pathView bezierPath]];
        [_barButton setTitle:@"Stop"];
        _animating = YES;
    }
}

- (void)updateAnimationForPath:(CGPathRef)path
{
    // To animate along a path we use a key frame animation (just like in the "Follow the Path" example).
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:MAXFLOAT];
    [animation setDuration:3.0];
    [animation setDelegate:self];
    [animation setCalculationMode:kCAAnimationPaced];
    
    [_layer addAnimation:animation forKey:@"bezierPathAnimation"];
}


@end
