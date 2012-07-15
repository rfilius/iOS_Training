//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Reuben Filius on 26/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *history;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)enterPressed;
- (IBAction)oopsPressed;


- (IBAction)test1Pressed;
- (IBAction)test2Pressed;
- (IBAction)test3Pressed;
- (IBAction)test4Pressed;

@end
