#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    
    NSNumber * sum = [[NSNumber alloc] initWithInt:0];
    for (NSNumber *element in array) {
        sum = @(element.integerValue + sum.integerValue);
    }
    return sum;
}

@end
