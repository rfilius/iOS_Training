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

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues {

    NSMutableArray *stack;
    NSString variableReplaceValue;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
        
        /*
         NSMutableArray method replaceObjectAtIndex:withObject: might be useful to you in this assignment. Note that you cannot call this method inside a for-in type of enumeration (since you don’t have the index in that case): you’d need a for loop that is iterating by index through the array.
         */

        // need to switch the variables over from variable to value in
        // the stack

        
        int i;
        for (i = 0; i < [stack count]; i++) {
            id thing = [stack objectAtIndex:i];
            
        // cannot use normal loop cause i need the index 
        //        for (id thing in stack) {

            if ([thing isKindOfClass:[NSString class]]) {
                //its a string, so lets see what it is. Ignore operations
                if ([thing isEqualToString:@"+"] ||
                    [thing isEqualToString:@"*"] ||
                    [thing isEqualToString:@"-"] ||
                    [thing isEqualToString:@"/"] ||
                    [thing isEqualToString:@"cos"] ||
                    [thing isEqualToString:@"sin"] ||
                    [thing isEqualToString:@"π"] ||
                    [thing isEqualToString:@"√"] ||
                    [thing isEqualToString:@"C"] 
                   ) {
                   // ignore the operations
                } else {
                    // so we have a string that is not an operation. look 
                    // it up in the dictionary and replace. If no find then
                    // make it 0
                    variableReplaceValue = [variableValues valueForKey:thing];
                    
                    // if the found delivers nil then make it 0;
                    if (!variableReplaceValue) variableReplaceValue = 0;
                    
                    [stack replaceObjectAtIndex:i withObject:variableReplaceValue]; 
                }
            }
        }
        
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
