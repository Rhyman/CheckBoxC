//
//  ViewController.m
//  CheckBoxC
//
//  Created by Richard Hyman on 2/14/19.
//  Copyright © 2019 Richard Hyman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  init the checkbox
        //    typical width is 30 to 50 pts; enlarged for demo
    checkbox1 = [[RAHCheckbox alloc] initWithRect:CGRectMake(52, 100, 100, 25)];
                //  this checkbox will be 100 x 100
    checkbox1.delegate = self;

    
    //  modify checkbox appearance
    //  the checkbox is initially checked on or off; default is off
    [checkbox1 setOn:YES animated:NO];
        //  the checkmark is animated when checked on or
        //  (if NO) the static, but slightly more stylish checkmark is displayed
        //  default is YES
    [checkbox1 animateMark:YES];
    //  change the duration of the animation; default is 0.5 secs
    [checkbox1 setAnimaDuration:0.35];
    
    //  modify checkbox (only) characteristics
        // change the background color of the checkbox; default is white
    [checkbox1 setBackgroundColor:[UIColor colorWithRed:0.5 green:1.0 blue:1.0 alpha:0.2]];
    // change the color and width of the border of the box; default is medium gray
    [checkbox1 setBoxBorderWidth:4];
    [checkbox1 setBoxBorderColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.8 alpha:1.0]];

    //  modify checkmark characteristics
        //  change checkmark color; the default is black
    [checkbox1 setCheckmarkColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]];
        //  change the stroke width used to draw the checkmark;
        //  default is 10% of full control width
    [checkbox1 setCheckmarkStrokeWidth: checkbox1.frame.size.width*0.14];
    //  use the XMark instead of a checkmark; default is NO
    [checkbox1 useXMark:NO];
    [self.view addSubview:checkbox1];

    
    //  use default widths and colors
    [self.checkbox2 animateMark:NO];
    [self.checkbox2 setOn:YES animated:NO];
    
    checkbox3 = [[RAHCheckbox alloc] initWithRect:CGRectMake(52, 340, 100, 25)];
    [checkbox3 setOn:YES animated:NO];
    [checkbox3 useXMark:YES];
    [checkbox3 setCheckmarkColor:[UIColor blueColor]];
    [checkbox3 animateMark:YES];  //  this is the default value
    [checkbox3 setAnimaDuration:1.0];
    [self.view addSubview:checkbox3];

}

//   delegated from RAHCheckbox
- (void)checkboxChangedValue:(BOOL)isOn {
    if(isOn) {
        [self.checkBoxLabel setText:@"Checkbox 1 is checked on."];
    } else {
        [self.checkBoxLabel setText:@"Checkbox 1 is checked off."];
    }
}


@end
