//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Reuben Filius on 27/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (strong, nonatomic) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray*)operandStack {

    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
    
}

- (double) popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void) pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void) clearOperandStack {
    [self.operandStack removeAllObjects];
}

- (double) performOperation:(NSString *)operation {
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand]+[self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand]*[self popOperand];
    }else if ([operation isEqualToString:@"-"]) {
        double subresult = [self popOperand];
        result = [self popOperand]-subresult;
    }else if ([operation isEqualToString:@"/"]) {
        double subresult = [self popOperand];
        if (subresult == 0) {
            result = 0;
        } else {
            result = [self popOperand]/subresult;
        }
    }else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    }else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    }else if ([operation isEqualToString:@"π"]) {
        result = M_PI;  //#define M_PI
    }else if ([operation isEqualToString:@"√"]) {
        result = sqrt([self popOperand]);
    }else if ([operation isEqualToString:@"C"]) {
        result = 0;
        [self clearOperandStack];
        
    }

    [self pushOperand:result];
    return (result);
}


@end
