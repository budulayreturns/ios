#import "Diagonal.h"
#import "tgmath.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
     
    [array retain];
    NSInteger sumOfPrimaryDiagonal = 0;
    NSInteger sumOfSecondaryDiagonal = 0;
        
            for (int i = 0; i<array.count; i++) {
                @autoreleasepool {
                 
                NSString *aString = [[NSString alloc] initWithFormat:@"%@", array[i]];
                NSArray *subArray = [aString componentsSeparatedByString:@" "];
                
                sumOfPrimaryDiagonal += [subArray[i] integerValue];
                sumOfSecondaryDiagonal += [subArray[array.count-i-1] integerValue];
                }
                
            }
    [array release];
    NSNumber *num = [[[NSNumber alloc] initWithInteger:(labs(sumOfPrimaryDiagonal - sumOfSecondaryDiagonal))] autorelease];
    
    return num;
}

@end
