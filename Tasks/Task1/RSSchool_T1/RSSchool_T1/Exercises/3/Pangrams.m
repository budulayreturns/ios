#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    [string retain];
    BOOL result = NO;
    NSCharacterSet *sentence = [NSCharacterSet characterSetWithCharactersInString:
                                 [string lowercaseString]];
    NSCharacterSet *alphabet = [NSCharacterSet characterSetWithCharactersInString:
                                 @"abcdefghijklmnopqrstuvwxyz"];
    
    if ([sentence isSupersetOfSet:alphabet]) {
        return YES;
    }
    [string release];
    return result;
}

@end
