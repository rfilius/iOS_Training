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
    NSString *variableReplaceValue;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
        
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

+ (BOOL) isOperation:(NSString *)command {
    if ([command isEqualToString:@"+"] ||
        [command isEqualToString:@"*"] ||
        [command isEqualToString:@"-"] ||
        [command isEqualToString:@"/"] ||
        [command isEqualToString:@"cos"] ||
        [command isEqualToString:@"sin"] ||
        [command isEqualToString:@"π"] ||
        [command isEqualToString:@"√"] ||
        [command isEqualToString:@"C"] 
        ) { 
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSSet *)variablesUsedInProgram:(id)program {
    
    NSMutableArray *stack;
    NSMutableSet *variableSet;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
        
        // look for the variables in the stack
        
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
                    // so we have a string that is not an operation. so this 
                    // is a variable, add it to the set 
                    [variableSet addObject:thing];
                }
            }
        }
        
    }
    
    // is ie nou nil ? of niet ? volgens mij wel ..
    return [variableSet copy];

}

+(NSString *)popDescriptionOffStack:(NSMutableArray *)stack {
    
    NSString *result;
    
    NSLog(@"stack = %@",stack);
    
    if ([stack count] > 0) {
    
        id topOfStack = [stack lastObject];
        if (topOfStack) [stack removeLastObject];
        
        if ([topOfStack isKindOfClass:[NSNumber class]]) {
            result = [topOfStack stringValue];
        } else if ([topOfStack isKindOfClass:[NSString class]]) {
            NSString *operation = topOfStack;
            
            if ([operation isEqualToString:@"+"]) {
                result = [@"(" stringByAppendingFormat:@"%@ %@ %@ %@",[self popDescriptionOffStack:stack],@"+",[self popDescriptionOffStack:stack],@")"];;
            } else if ([operation isEqualToString:@"*"]) {
                result = [@"(" stringByAppendingFormat:@"%@ %@ %@ %@",[self popDescriptionOffStack:stack],@"*",[self popDescriptionOffStack:stack],@")"];
                
            }else if ([operation isEqualToString:@"-"]) {
                NSString *subresult = [self popDescriptionOffStack:stack];
                result = [[self popDescriptionOffStack:stack] stringByAppendingFormat:@"%@ %@",@"-", subresult];
                
            }else if ([operation isEqualToString:@"/"]) {
                NSString *subresult = [self popDescriptionOffStack:stack];
                result = [[self popDescriptionOffStack:stack] stringByAppendingFormat:@"%@ %@",@"/", subresult];
                
            }else if ([operation isEqualToString:@"sin"]) {
                result = [@"sin(" stringByAppendingFormat:@"%@ %@",[self popDescriptionOffStack:stack],@")"];
                
            }else if ([operation isEqualToString:@"cos"]) {
                result = [@"cos(" stringByAppendingFormat:@"%@ %@",[self popDescriptionOffStack:stack],@")"];
                
                
            }else if ([operation isEqualToString:@"π"]) {
                result = @"π";  //#define M_PI
                
            }else if ([operation isEqualToString:@"√"]) {
                result = [@"sqrt(" stringByAppendingFormat:@"%@ %@",[self popDescriptionOffStack:stack],@")"];            
            }
            
        }
        
    }
    
    NSLog(@"result: %@",result);
    return result;
    
}

+(NSString *)descriptionOfProgram:(id)program {

    NSString *result;
    if ([program isKindOfClass:[NSArray class]]) {
        result = [self popDescriptionOffStack:[program mutableCopy]];
    }
    
    return result;
    
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

- (NSString *) getDescription {
    return [CalculatorBrain descriptionOfProgram:self.program];
}

@end
