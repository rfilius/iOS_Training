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
- (double) performOperation:(NSString *)operation usingVariableValues:(NSDictionary *)variableValues;
- (NSString *) getDescription;
- (NSSet *) getVariables;

@property (readonly) id program;

+(double)runProgram:(id)program;
+(double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+(NSString *)descriptionOfProgram:(id)program;
+(NSSet *)variablesUsedInProgram:(id)program;

@end
 