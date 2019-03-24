#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    
    NSCharacterSet *sentence = [NSCharacterSet characterSetWithCharactersInString:
                                [string lowercaseString]];
    NSCharacterSet *alphabet = [NSCharacterSet characterSetWithCharactersInString:
                                @"abcdefghijklmnopqrstuvwxyz"];
    
    if ([sentence isSupersetOfSet:alphabet]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
