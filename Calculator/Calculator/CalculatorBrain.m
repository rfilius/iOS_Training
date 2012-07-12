//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Reuben Filius on 27/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (strong, nonatomic) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;

- (NSMutableArray*)programStack {

    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
    
}

- (void) pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

-(id)program {
    return [self.programStack copy];
}

+(double)runProgram:(id)program {
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+(NSString *)descriptionOfProgram:(id)program {
    return @"jaja";
}

+(double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;

    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        return [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack]+[self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack]*[self popOperandOffStack:stack];
        }else if ([operation isEqualToString:@"-"]) {
            double subresult = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack]-subresult;
        }else if ([operation isEqualToString:@"/"]) {
            double subresult = [self popOperandOffStack:stack];
            if (subresult == 0) {
                result = 0;
            } else {
                result = [self popOperandOffStack:stack]/subresult;
            }
        }else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffStack:stack]);
        }else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffStack:stack]);
        }else if ([operation isEqualToString:@"π"]) {
            result = M_PI;  //#define M_PI
        }else if ([operation isEqualToString:@"√"]) {
            result = sqrt([self popOperandOffStack:stack]);
        }else if ([operation isEqualToString:@"C"]) {
            result = 0;
            [stack removeAllObjects];
            
        }

    }
     
    return result;
    
}

- (double) performOperation:(NSString *)operation {
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}


@end
