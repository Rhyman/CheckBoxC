//
//  RAHCheckbox.h
//  testLayers
//
//  Created by Richard Hyman on 8/27/11.
//  Copyright 2011-2019 R.A.Hyman. All rights reserved.
//

#import <UIKit/UIKit.h>

//      protocol below lets the parent viewController know
//   when the checkbox value changes
@protocol RAHCheckboxDelegate;



@interface RAHCheckbox : UIControl {
	
	double ifullRectW;  //  taken from the width of the rect used to init this view
					//  used as characteristic length for all layer sizing/drawing
                    //     Based on the width of the defined box containing this
                    //  control; the height is ignored, and a square box
                    //  is constructed.
        
    CALayer         *iBackground;
    CALayer         *iCheckBox;
    CAShapeLayer    *iCheckMark;
    
    //    checkbox
    UIColor         *colorForBackground;
    UIColor         *checkboxColor;
    CGFloat         checkboxBorderWidth;
    
    //    checkmark
    UIColor         *checkmarkColor;
    CGFloat         checkmarkWidth;
    BOOL            useXMark;
    BOOL            on;
    
    //    animation
    CGFloat         checkmarkAnimationDuration;
    BOOL            animateCheckMark;
}

@property (nonatomic, weak) id <RAHCheckboxDelegate> delegate;

//    Init the checkbox control in the defined rect; the width is
//  used to create a square space; the height is ignored
//    The visible checkbox is 15% smaller on each side than this rect.
//  In use, a typical width of this rect is 40 to 50 points
//  The full rect reacts to user touches, including the small, invisible
//  area outside of the checkbox
- (id)initWithRect:(CGRect)fullRect;

//  adjust the frame that encompasses the entire control
- (void)adjustFrame:(CGRect)rect;

//    Determine if the control is currently set on or off
- (BOOL)isOn;

//    When created, the checkmark can be on or off; default is off
- (void)setOn:(BOOL)setOn animated:(BOOL)animated;

//    Indicate if the animated checkmark should be used, when checkmark is
//  drawn; when animated, the checkmark is a simple line of constant width
//    When not animated, the static checkmark is a little more stylish
//    The default is YES
- (void)animateMark:(BOOL)animate;
//  set duration of animation, when checkmark is animated; default is 0.5 secs
- (void)setAnimaDuration:(CGFloat)aDuration;

            //  checkbox characteristics
//    Set the checkbox background color; default is white
//    Set the checkbox border color; default is medium gray
//    Set the checkbox border width; default is 4% of the full control width
- (void)setBackgroundColor:(UIColor *)aColor;
- (void)setBoxBorderColor:(UIColor *)aColor;
- (void)setBoxBorderWidth:(CGFloat)aWidth;

            //  checkmark characteristics
//    Set the checkmark color; default is black
//    Set width of pen that draws checkmark; default is 10% of full control width
//    Use the X mark in the checkbox, rather than the checkmark; default is NO
- (void)setCheckmarkColor:(UIColor *)aColor;
- (void)setCheckmarkStrokeWidth:(CGFloat)aWidth;
- (void)useXMark:(BOOL)useXcheckmark;


@end




@protocol RAHCheckboxDelegate
    //  the delegate protocol is called when the checkbox is tapped
@optional
- (void)checkboxChangedValue:(BOOL)isOn;

@end


