//
//  ViewController.h
//  CheckBoxC
//
//  Created by Richard Hyman on 2/14/19.
//  Copyright © 2019 Richard Hyman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAHCheckbox.h"


@interface ViewController : UIViewController <RAHCheckboxDelegate> {

    RAHCheckbox         *checkbox1;
    RAHCheckbox         *checkbox3;

}

@property (weak, nonatomic) IBOutlet UILabel    *checkBoxLabel;

@property (weak, nonatomic) IBOutlet RAHCheckbox    *checkbox2;



@end

