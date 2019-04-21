//
//  NSString+RSSchool_T4_Extension.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NSString+RSSchool_T4_Extension.h"

@implementation NSString (RSSchool_T4_Extension)
- (NSInteger) rs_containsNumericCharacters {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"[0-9]{1}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    [regex release];
    return numberOfMatches;
}

- (BOOL) rs_containsSpecialCharacters {
    NSCharacterSet *validCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *invalidCharacterSet = validCharacterSet.invertedSet;
    NSRange range = [[self stringByReplacingOccurrencesOfString:@"+" withString:@""] rangeOfCharacterFromSet:invalidCharacterSet];
    return range.location != NSNotFound ? YES : NO;
}

- (NSString*) rs_getNumbersFromString {
    //NSCharacterSet *validCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *validCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *invalidCharacterSet = validCharacterSet.invertedSet;
    NSString *clearedText = [[[[self componentsSeparatedByCharactersInSet:invalidCharacterSet] componentsJoinedByString:@""] copy] autorelease];
    return clearedText;
}

- (NSString*) rs_appendPlusPrefix {
    NSString *plus = [[NSString alloc]initWithString:@"+"];
    NSMutableString *stringWithPrefix = [[[NSMutableString alloc] initWithString:self] autorelease];
    if (![self hasPrefix:plus]){
        if ([self containsString:plus]){
            [stringWithPrefix replaceOccurrencesOfString:plus withString:@"" options:0 range:NSMakeRange(0, stringWithPrefix.length)];
        }
        [stringWithPrefix insertString:plus atIndex:0];
    }
    [plus release];
    return stringWithPrefix;
}

+ (NSString *) rs_formatPhoneNumber: (NSString*) number withFormat: (NSString*) format andCodeLength:(NSInteger) codeLength  {
    [number retain];
    [format retain];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"x"];
    __block NSMutableString *formattedString = [[NSMutableString alloc] initWithString:format];
    __block NSInteger loc = 0;
    [format release];
    NSString *num = [[NSString alloc] initWithString:[number substringFromIndex:codeLength]];
    NSString *code = [[NSString alloc] initWithString:[number substringToIndex:codeLength]];
    [number release];
    
    if (num.length) {
        [num enumerateSubstringsInRange:NSMakeRange(0, num.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            NSRange range = [formattedString rangeOfCharacterFromSet:set options:0 range:NSMakeRange(0, formattedString.length)];
            if (range.location!=NSNotFound) {
                [formattedString replaceCharactersInRange:range withString:substring];
                loc = range.location;
            }
            else {
                *stop = YES;
            }
        }];
    }
    [num release];
    NSString *result = num.length ? [[[NSString stringWithFormat:@"%@ %@", code, [formattedString substringWithRange:NSMakeRange(0, loc+1)]] copy] autorelease] : [[[NSString stringWithFormat:@"%@",code] copy] autorelease];
    [formattedString release];
    [code release];
    return result;
}

@end

//- (NSString*) rs_appendPlusPrefix {
//    NSString *plus = [[NSString alloc]initWithString:@"+"];
//    NSString *stringWithPlus = [self hasPrefix:plus] ? [self copy] : [[[NSString alloc] initWithString:[plus stringByAppendingString:self]] autorelease];
//    [plus release];
//    return stringWithPlus;
//}
//- (NSString*) rs_removePlusPrefix {
//    NSString *plus = [[NSString alloc]initWithString:@"+"];
//    NSString *stringWithoutPlus = [self containsString:plus] ? [[[NSString alloc] initWithString:[self stringByReplacingOccurrencesOfString:plus withString:@""]] autorelease] : [self copy];
//    [plus release];
//    return stringWithoutPlus;
//}
