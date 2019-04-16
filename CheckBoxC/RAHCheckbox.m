//
//  RAHCheckbox.m
//  testLayers
//
//  Created by Richard Hyman on 8/27/11.
//  Copyright 2011-2019 R.A.Hyman. All rights reserved.
//

#import "RAHCheckbox.h"


@implementation RAHCheckbox


#pragma mark - __________ Init views and defaults

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
   
    [self setupInRect:self.frame];
    
    return self;
}

- (id)initWithRect:(CGRect)fullRect  {
	self = [super initWithFrame:fullRect];
    if (self) {
        [self setupInRect:fullRect];
    }
    return self;
}


- (void)setupInRect:(CGRect)theRect {
    //    we will set up the view as a square, even if the user input a rect
    //  gfullRectW is used as the characteristic size for defining the
    //  checkbox and checkmark
    ifullRectW = theRect.size.width;
    
    [self setupControlFrameAndBackground: theRect];
    
    //  init the defaults for the properties the programmer can change
    [self setupDefaults: theRect];
    
    //  set up the checkbox and the checkmark
    [self setupCheckboxComponents: theRect];
    
    //  show the checkmark;  default is off
    on = NO;
    [self drawCheckBox];
    //  init with the checkmark not drawn
}

- (void)setupControlFrameAndBackground:(CGRect)theRect {
    CGFloat rectWidth = theRect.size.width;
    //    set up the frame for the entire control, which is about 15%
    //  larger than the checkbox on all 4 sides
    self.frame = CGRectMake(theRect.origin.x , theRect.origin.y, rectWidth, rectWidth);
    self.backgroundColor = [UIColor clearColor];
    
    //  the background behind the checkbox
    iBackground = [CALayer layer];
    //  background frame is relative to self; not view containing self
    iBackground.frame = CGRectMake(rectWidth*0.2, rectWidth*0.2, rectWidth*0.6, rectWidth*0.6);
    
    //  set up the checkbox background color as white
    colorForBackground = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];  //  init to white
    iBackground.backgroundColor = colorForBackground.CGColor;
    
    [self.layer addSublayer:iBackground];
}

- (void)setupDefaults:(CGRect)theRect {
    CGFloat rectWidth = theRect.size.width;
    checkboxBorderWidth = 0.04 * rectWidth;
    checkboxColor = [[UIColor alloc] initWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    checkmarkWidth = 0.10 * rectWidth;
    checkmarkColor = [UIColor blackColor];
    checkmarkAnimationDuration = 0.5;
    animateCheckMark = YES;
    useXMark = NO;
}

- (void)setupCheckboxComponents:(CGRect)theRect {
    CGFloat rectWidth = theRect.size.width;

    iCheckBox = [CALayer layer];
    iCheckMark = [CAShapeLayer layer];
    
    iCheckBox.frame = CGRectMake(0, 0, rectWidth, rectWidth);
    iCheckBox.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:iCheckBox];
    
    iCheckMark.frame = CGRectMake(0, 0, rectWidth, rectWidth);
    iCheckMark.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:iCheckMark];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    //  the rect is defined in the InterfaceBuilder
    //  make sure the height is equal to the width
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    if(heightConstraint != nil) {
        heightConstraint.constant = self.frame.size.width;
    }
}



#pragma mark - __________ change checkbox & checkmark properties

//  adjust the frame that encompasses the entire control
- (void)adjustFrame:(CGRect)rect {
    self.frame = rect;
    [iBackground removeFromSuperlayer];
    [iCheckBox removeFromSuperlayer];
    [iCheckMark removeFromSuperlayer];
    [self setupInRect:rect];
}

- (void)setBackgroundColor:(UIColor *)aColor {
    colorForBackground = aColor;
    iBackground.backgroundColor = colorForBackground.CGColor;
}

- (void)setBoxBorderColor:(UIColor *)aColor {
    checkboxColor = aColor;
    [self drawCheckBox];
}

- (void)setBoxBorderWidth:(CGFloat)aWidth {
    checkboxBorderWidth = aWidth;
    [self drawCheckBox];
}

- (void)setCheckmarkColor:(UIColor *)aColor {
    checkmarkColor = aColor;
    [self drawCheckMark];
}

- (void)setCheckmarkStrokeWidth:(CGFloat)aWidth {
    checkmarkWidth = aWidth;
    [self drawCheckMark];
}

- (void)setAnimaDuration:(CGFloat)aDuration {
    checkmarkAnimationDuration = aDuration;
    [self drawCheckMark];
}

- (void)animateMark:(BOOL)animate {
    animateCheckMark = animate;
    [self drawCheckMark];
}

- (void)useXMark:(BOOL)useXcheckmark {
    useXMark = useXcheckmark;
    [self drawCheckMark];
}


#pragma mark - __________ draw checkbox & checkmark

- (void)drawCheckBox {
    if(iCheckBox != nil) {
        [iCheckBox removeFromSuperlayer];
    }
    CGFloat refXLength = ifullRectW;
    CGFloat borderWidth = checkboxBorderWidth;
    // create bezier path
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    UIColor *strokeColor = checkboxColor;
    UIColor *fillColor = [UIColor clearColor];
    
    [aPath moveToPoint:CGPointMake(0.15*refXLength, (0.15*refXLength + 0.5*borderWidth))];  // left most point
    [aPath addLineToPoint:CGPointMake((0.85*refXLength - 0.5*borderWidth), (0.15*refXLength + 0.5*borderWidth))];  //  right most vertice
    [aPath addLineToPoint:CGPointMake((0.85*refXLength - 0.5*borderWidth), (0.85*refXLength - 0.5*borderWidth))];  //  bottom right
    [aPath addLineToPoint:CGPointMake((0.15*refXLength + 0.5*borderWidth), (0.85*refXLength - 0.5*borderWidth))];  //  bottom right to bottom left
    [aPath addLineToPoint:CGPointMake((0.15*refXLength + 0.5*borderWidth), (0.15*refXLength + 0.5*borderWidth))];

    // create shape layer for the defined path
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setStrokeColor:strokeColor.CGColor];
    [shapeLayer setFillColor:fillColor.CGColor];
    [shapeLayer setLineWidth: checkboxBorderWidth];
    shapeLayer.path = aPath.CGPath;
    
    iCheckBox = shapeLayer;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawCheckMark {
    if(!on) {
        return;
    }
    if(iCheckMark != nil) {
        [iCheckMark removeFromSuperlayer];
    }
    CGFloat refXLength = ifullRectW;
    // create bezier path
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    UIColor *strokeColor;
    UIColor *fillColor;
    if(animateCheckMark && !useXMark) {
        [aPath moveToPoint:CGPointMake((0.25*refXLength), (0.42*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.48*refXLength), (0.66*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.77*refXLength), (0.005*refXLength))];
        strokeColor = checkmarkColor;
        fillColor = [UIColor clearColor];
    } else if(!animateCheckMark && !useXMark) {
        [aPath moveToPoint:CGPointMake((0.25*refXLength), (0.42*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.46*refXLength), (0.68*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.79*refXLength), (0.015*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.78*refXLength), (0.005*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.455*refXLength), (0.57*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.27*refXLength), (0.395*refXLength))];
        [aPath closePath];
        strokeColor = checkmarkColor;
        fillColor = checkmarkColor;
    } else {  //  useXMark, for both animated and not animated
        [aPath moveToPoint:CGPointMake((0.3*refXLength), (0.3*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.7*refXLength), (0.7*refXLength))];
        [aPath moveToPoint:CGPointMake((0.7*refXLength), (0.3*refXLength))];
        [aPath addLineToPoint:CGPointMake((0.3*refXLength), (0.7*refXLength))];
        strokeColor = checkmarkColor;
        fillColor = [UIColor clearColor];
    }

    
    // create shape layer for the defined path
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setStrokeColor:strokeColor.CGColor];
    [shapeLayer setFillColor:fillColor.CGColor];
    [shapeLayer setLineWidth: checkmarkWidth];
    shapeLayer.path = aPath.CGPath;
    if(useXMark) {
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineJoin = kCALineCapRound;
    }
    
    // animate it
    //    https://oleb.net/blog/2010/12/animating-drawing-of-cgpath-with-cashapelayer/
    //    https://collectiveidea.com/blog/archives/2017/12/04/cabasicanimation-for-animating-strokes-plus-a-bonus-gratuitous-ui-interaction
    
    if(animateCheckMark) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = checkmarkAnimationDuration;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    
    iCheckMark = shapeLayer;
    [self.layer addSublayer:shapeLayer];
}



#pragma mark - __________ track touches

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event  {
    //  the control momentarily dims when touched to provide feedback
	[self setAlpha:0.7];
	[self setNeedsDisplay];
	return YES;
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event  {
	[self setAlpha:1.0];
	[self setNeedsDisplay];
	
    if(touch.view ==  self)  {
        if(on)  {
            on = NO;
            __weak __typeof__(self) weakSelf = self;
            
            if(animateCheckMark) {
                //  use CATransaction for the completion block of fade animation
                [CATransaction begin];
                CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                fadeAnimation.duration = checkmarkAnimationDuration*0.5;
                fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
                fadeAnimation.toValue = [NSNumber numberWithFloat:0.0f];
                [CATransaction setCompletionBlock:^{__typeof__(self) strongSelf = weakSelf; [strongSelf->iCheckMark removeFromSuperlayer];}];
                [iCheckMark addAnimation:fadeAnimation forKey:@"fadeAnimation"];
                [CATransaction commit];

            } else {
                [iCheckMark removeFromSuperlayer];
            }
        } else {
            on = YES;
            [self drawCheckMark];
        }
        [self.delegate checkboxChangedValue:on];
    }
}



#pragma mark - __________ determine and set state

- (BOOL)isOn {
    return on;
}

- (void)setOn:(BOOL)setOn animated:(BOOL)animated  {
    BOOL saveAnimateSetting = animateCheckMark;
    if(animated) {
        animateCheckMark = YES;
    }
	if(setOn)  {
		on = YES;
        [self drawCheckMark];
	} else {
		on = NO;
        if(iCheckMark != nil) {
            [iCheckMark removeFromSuperlayer];
        }
	}
    animateCheckMark = saveAnimateSetting;
}


@end
