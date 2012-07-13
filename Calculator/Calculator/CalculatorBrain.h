//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Reuben Filius on 27/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double) performOperation:(NSString *)operation;

@property (readonly) id program;

+(double)runProgram:(id)program;
+(double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+(NSString *)descriptionOfProgram:(id)program;

@end
 