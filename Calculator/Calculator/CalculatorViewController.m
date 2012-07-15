//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Reuben Filius on 26/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize history = _history;
@synthesize brain = _brain;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    //NSLog(@"pressed digit %@",sender.currentTitle);
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([sender.currentTitle isEqualToString:@"."]) {
            NSRange ranged = [self.display.text rangeOfString:@"."];
            if (ranged.location == NSNotFound) {
                self.display.text = [self.display.text stringByAppendingFormat:sender.currentTitle];    
          //      self.history.text = [self.history.text stringByAppendingFormat:sender.currentTitle];
            }
        } else {
            self.display.text = [self.display.text stringByAppendingFormat:sender.currentTitle];    
          //  self.history.text = [self.history.text stringByAppendingFormat:sender.currentTitle];
        }
        
        
    } else {
        if ([sender.currentTitle isEqualToString:@"0"])  {
            // do nothing
        } else if ([sender.currentTitle isEqualToString:@"."]) {
            self.display.text = [@"0" stringByAppendingFormat:sender.currentTitle];
            self.userIsInTheMiddleOfEnteringANumber = YES;    
     //       self.history.text = [self.history.text stringByAppendingFormat:[@" " stringByAppendingFormat:sender.currentTitle]];
        } else {
            self.display.text = sender.currentTitle;
            self.userIsInTheMiddleOfEnteringANumber = YES;
       //     self.history.text = [self.history.text stringByAppendingFormat:[@" " stringByAppendingFormat:sender.currentTitle]];
        }
        
            
    }
    
    self.history.text = [self.brain getDescription];

- (IBAction)xPressed {
}

- (IBAction)aPressed {
}

- (IBAction)bPressed {
}

- (IBAction)fooPressed {
}

- (IBAction)test1Pressed {
}

- (IBAction)test2Pressed {
}

- (IBAction)test3Pressed {
}

- (IBAction)test4Pressed {
}
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    //self.history.text = [self.history.text stringByAppendingFormat:[@" " stringByAppendingFormat:sender.currentTitle]];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    //self.history.text = [self.history.text stringByAppendingFormat:[@"=" stringByAppendingFormat:resultString]];
    
    self.history.text = [self.brain getDescription];

    
    if ([sender.currentTitle isEqualToString:@"C"]) {
        self.history.text = @"";
    }
    }

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
   // self.history.text = [self.history.text stringByAppendingFormat:[@" " stringByAppendingFormat:self.display.text]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    self.history.text = [self.brain getDescription];

}

- (IBAction)oopsPressed {
    if ([self.display.text length] > 0 && self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        //if ([self.history.text length] > 0) {
        //    self.history.text = [self.history.text substringToIndex:[self.history.text length]-1];
        //}
    }
    
}
- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
