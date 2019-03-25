#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
   
    [array retain];
    NSNumber * sum = [[[NSNumber alloc] initWithInt:0] autorelease];
    for (NSNumber *element in array) {
        sum = @(element.integerValue + sum.integerValue);
    }
    [array release];
    return sum;
}

@end
