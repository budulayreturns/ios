#import "FullBinaryTrees.h"
// good luck



@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count {
    
    NSCharacterSet *nullSet = [NSCharacterSet characterSetWithCharactersInString:@",null"];
    NSMutableString *bTString = [[[NSMutableString alloc] init] autorelease];
    [bTString appendFormat:@"["];
    if(count % 2 != 0) {
        count-=1;
        NSString *rootString = [[NSString alloc] initWithString:@"0"];
        NSArray *arrayOfNodesStrings = [self arrayOfStringsForNodeCount:count];
        for (int i =0; i < arrayOfNodesStrings.count; i++) {
            NSString *nodeString = [arrayOfNodesStrings[i] stringByTrimmingCharactersInSet:nullSet];
            [bTString appendFormat:@"[%@%@%@]",rootString,([nodeString isEqualToString:@""] ? @"": @","), nodeString];
        }
        [rootString release];
    }
    [bTString appendFormat:@"]"];
    NSLog(@"%@", bTString);
    return bTString;
}

- (NSArray *) arrayOfStringsForNodeCount: (NSUInteger) count {
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    if (count == 0) {
        NSString *s = [[NSString alloc] initWithFormat:@"null,null"];
        [array addObject:s];
        [s release];
    }
    else {
        count-=2;
        NSInteger i;
        NSInteger j;
        for (i = count, j=0; i <= count; i-=2, j+=2) {
            NSArray *a1 = [self arrayOfStringsForNodeCount:i];
            NSArray *a2 = [self arrayOfStringsForNodeCount:j];
            
            for (int k =0; k < a1.count; k++) {
                for (int m = 0; m < a2.count; m++) {
                    NSString *s = [[NSString alloc] initWithFormat:@"0,0,%@,%@", a1[k], a2[m]];
                    [array addObject:s];
                    [s release];
                }
            }
        }
    }
    return array;
}


@end
