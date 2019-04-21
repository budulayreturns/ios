//
//  NSString+RSSchool_T4_Extension.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NSString+RSSchool_T4_Extension.h"

@implementation NSString (RSSchool_T4_Extension)
- (NSInteger) containsNumericCharacters {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"[0-9]{1}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    [regex release];
    return numberOfMatches;
}

- (NSString*) getNumbersFromString {
    //NSCharacterSet *validCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *validCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *invalidCharacterSet = validCharacterSet.invertedSet;
    NSString *clearedText = [[[[self componentsSeparatedByCharactersInSet:invalidCharacterSet] componentsJoinedByString:@""] copy] autorelease];
    return clearedText;
}

- (NSString*) appendPlusPrefix {
    NSString *plus = [[NSString alloc]initWithString:@"+"];
    NSString *stringWithPlus = [self hasPrefix:plus] ? [self copy] : [[[NSString alloc] initWithString:[plus stringByAppendingString:self]] autorelease];
    [plus release];
    return stringWithPlus;
}

- (NSString*) removePlusPrefix {
    NSString *plus = [[NSString alloc]initWithString:@"+"];
    NSString *stringWithoutPlus = [self containsString:plus] ? [[[NSString alloc] initWithString:[self stringByReplacingOccurrencesOfString:plus withString:@""]] autorelease] : [self copy];
    [plus release];
    return stringWithoutPlus;
}

@end
