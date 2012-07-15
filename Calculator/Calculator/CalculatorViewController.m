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
@property (nonatomic, strong) NSMutableDictionary *testVariableValues;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize history = _history;
@synthesize brain = _brain;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize testVariableValues = _testVariableValues;

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
            }
        } else {
            self.display.text = [self.display.text stringByAppendingFormat:sender.currentTitle];    
        }
        
        
    } else {
        if ([sender.currentTitle isEqualToString:@"0"])  {
            // do nothing
        } else if ([sender.currentTitle isEqualToString:@"."]) {
            self.display.text = [@"0" stringByAppendingFormat:sender.currentTitle];
            self.userIsInTheMiddleOfEnteringANumber = YES;    
        } else {
            self.display.text = sender.currentTitle;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
        
            
    }
    
    self.history.text = [self.brain getDescription];
}
    
- (IBAction)test1Pressed {
    [self.testVariableValues setValue:[NSNumber numberWithDouble:3]  forKey:@"x"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:5]  forKey:@"a"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:8]  forKey:@"b"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:9]  forKey:@"foo"];
}

- (IBAction)test2Pressed {
    [self.testVariableValues setValue:[NSNumber numberWithDouble:2]  forKey:@"x"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:1]  forKey:@"a"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:15]  forKey:@"b"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:3]  forKey:@"foo"];
}

- (IBAction)test3Pressed {
    [self.testVariableValues setValue:[NSNumber numberWithDouble:8]  forKey:@"x"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:32]  forKey:@"a"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:87]  forKey:@"b"];
    [self.testVariableValues setValue:[NSNumber numberWithDouble:91]  forKey:@"foo"];
}

- (IBAction)test4Pressed {
    self.testVariableValues = nil;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    self.history.text = [self.brain getDescription];
    if ([sender.currentTitle isEqualToString:@"C"]) {
        self.history.text = @"";
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    self.history.text = [self.brain getDescription];

}

- (IBAction)oopsPressed {
    if ([self.display.text length] > 0 && self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    }
    
}
- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
