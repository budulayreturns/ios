#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
   
    NSInteger length = string.length;
    NSInteger rows = floorf(sqrtf(length));
    NSInteger cols = ceilf(sqrtf(length));
    [string retain];
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
   
    while (rows*cols < length && rows <= cols) {
        rows+=1;
    }
    for (int i = 0; i < cols; i++) {
        @autoreleasepool {
            NSMutableString *resultString = [[NSMutableString alloc] init];
            for (int j = i; j < length; j+=cols) {
                [resultString appendString:[string substringWithRange:NSMakeRange(j, 1)]];
            }
            [array addObject:resultString];
        }
    }
    [string release];
    return [array componentsJoinedByString:@" "] ;
}
@end
