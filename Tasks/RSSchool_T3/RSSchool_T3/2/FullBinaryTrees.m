#import "FullBinaryTrees.h"
// good luck

@implementation FullBinaryTrees

- (NSArray *) arrayOfStringsForNodeCount: (NSUInteger) count {
    NSMutableArray *arrayOfStrings = [[[NSMutableArray alloc] init] autorelease];
    if (count == 0) {
        NSString *nullNodeString = [[NSString alloc] initWithFormat:@"null,null"];
        [arrayOfStrings addObject:nullNodeString];
        [nullNodeString release];
    }
    else {
        count-=2;
        NSInteger i;
        NSInteger j;
        for (i = count, j=0; i <= count; i-=2, j+=2) {
            NSArray *leftArrayOfStrings = [[self arrayOfStringsForNodeCount:i] retain];
            NSArray *rightArrayOfStrings = [[self arrayOfStringsForNodeCount:j] retain];
            for (int k =0; k < leftArrayOfStrings.count; k++) {
                for (int m = 0; m < rightArrayOfStrings.count; m++) {
                    NSString *resultString = [[NSString alloc] initWithFormat:@"0,0,%@,%@", leftArrayOfStrings[k], rightArrayOfStrings[m]];
                    [arrayOfStrings addObject:resultString];
                    [resultString release];
                }
            }
            [leftArrayOfStrings release];
            [rightArrayOfStrings release];
        }
    }
    return arrayOfStrings;
}

- (NSString *)stringForNodeCount:(NSInteger)count {

    NSCharacterSet *nullSet = [[NSCharacterSet characterSetWithCharactersInString:@",null"] retain];
    NSMutableString *bTString = [[[NSMutableString alloc] init] autorelease];
    [bTString appendFormat:@"["];
    if(count % 2 != 0) {
        count-=1;
        NSString *rootString = [[NSString alloc] initWithString:@"0"];
        NSArray *arrayOfNodesStrings = [[self arrayOfStringsForNodeCount:count] retain];
        for (int i =0; i < arrayOfNodesStrings.count; i++) {
            NSString *nodeString = [[arrayOfNodesStrings[i] stringByTrimmingCharactersInSet:nullSet] retain];
            [bTString appendFormat:@"[%@%@%@]",rootString,([nodeString isEqualToString:@""] ? @"": @","), nodeString];
            [nodeString release];
            if (i != arrayOfNodesStrings.count-1){
                [bTString appendString:@","];
            }
        }
        [arrayOfNodesStrings release];
        [rootString release];
    }
    [nullSet release];
    [bTString appendFormat:@"]"];
    NSLog(@"%@", bTString);
    return bTString;
}

//- (NSString*) clipRoot: (NSString*) rootString andArrayOfNodeStrings: (NSArray *) arrayOfNodeStrings {
//    [rootString retain];
//    [arrayOfNodeStrings retain];
//    NSCharacterSet *nullSet = [NSCharacterSet characterSetWithCharactersInString:@",null"];
//    NSMutableString *clippedString = [[[NSMutableString alloc] init] autorelease];
//    [arrayOfNodeStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *nodeString = [[obj stringByTrimmingCharactersInSet:nullSet] retain];
//        [clippedString appendFormat:@"[%@%@%@]",rootString,([nodeString isEqualToString:@""] ? @"": @","), nodeString];
//        if (idx != arrayOfNodeStrings.count-1){
//            [clippedString appendString:@","];
//        }
//        [nodeString release];
//    }];
//    [arrayOfNodeStrings release];
//    [rootString release];
//    return clippedString;
//}
//
//
//
//
//
//- (NSString *)stringForNodeCount:(NSInteger)count {
//    NSString* (^blockTree) (NSInteger) = ^NSString*(NSInteger count) {
//        NSString *rootString = [[NSString alloc] initWithString:@"0"];
//        NSArray *arrayOfNodesStrings = [[self arrayOfStringsForNodeCount:count] retain];
//        NSString *resultString = [[self clipRoot:rootString andArrayOfNodeStrings:arrayOfNodesStrings] retain];
//        [arrayOfNodesStrings release];
//        [rootString release];
//        return resultString;
//    };
//    NSString *nodeString = [[count % 2 != 0 ? [NSString stringWithFormat:@"[%@]", [[blockTree(--count) copy] autorelease]] : @"[]" retain] autorelease];
//    NSLog(@"%@", nodeString);
//    return nodeString;
//}
//
//- (NSArray *) arrayOfStringsForNodeCount: (NSUInteger) count {
//    NSMutableArray *arrayOfStrings = [[[NSMutableArray alloc] init] autorelease];
//    if (count == 0) {
//        NSString *nullNodeString = [[NSString alloc] initWithFormat:@"null,null"];
//        [arrayOfStrings addObject:nullNodeString];
//        [nullNodeString release];
//    }
//    else {
//        count-=2;
//        NSInteger i;
//        NSInteger j;
//        for (i = count, j=0; i <= count; i-=2, j+=2) {
//            NSArray *leftArrayOfStrings = [[self arrayOfStringsForNodeCount:i] retain];
//            NSArray *rightArrayOfStrings = [[self arrayOfStringsForNodeCount:j] retain];
//            NSArray *clippedArray = [[self clipArray:leftArrayOfStrings withArray:rightArrayOfStrings] retain];
//            [arrayOfStrings addObjectsFromArray:clippedArray];
//            [clippedArray release];
//            //[leftArrayOfStrings release];
//            //[rightArrayOfStrings release];
//        }
//    }
//    return arrayOfStrings;
//}

//- (NSArray *) arrayOfStringsForNodeCount: (NSInteger) count {
//
//    NSArray* (^childTreeBlock) (NSInteger) = ^NSArray*(NSInteger count) {
//        count-=2;
//        NSInteger i;
//        NSInteger j;
//        NSMutableArray *arrayOfStrings = [[[NSMutableArray alloc] init] autorelease];
//        for (i = count, j=0; i <= count; i-=2, j+=2) {
//            NSArray *leftArrayOfStrings = [[self arrayOfStringsForNodeCount:i] retain];
//            NSArray *rightArrayOfStrings = [[self arrayOfStringsForNodeCount:j] retain];
//            NSArray *clippedArray = [[self clipArray:leftArrayOfStrings withArray:rightArrayOfStrings] retain];
//            [arrayOfStrings addObjectsFromArray:clippedArray];
//            [clippedArray release];
//            [leftArrayOfStrings release];
//            [rightArrayOfStrings release];
//        }
//        return arrayOfStrings;
//    };
//
//    NSArray* (^nullChildBlock) (void) = ^NSArray*(void) {
//        NSString *nullNodeString = [[self getNullChildString] retain];
//        NSLog(@"%lu", (unsigned long)nullNodeString.retainCount);
//        NSArray *arrayNullString = [[[NSArray alloc] initWithObjects:nullNodeString, nil] autorelease];
//        [nullNodeString release];
//        return arrayNullString;
//    };
//
//    NSArray *array = [[count == 0 ? [[nullChildBlock() copy] autorelease] : [[childTreeBlock(count) copy] autorelease] retain] autorelease];
//    return array;
//}

//
//- (NSArray *) clipArray: (NSArray*) leftArray withArray: (NSArray*) rightArray {
//    [rightArray retain];
//    [leftArray release];
//    NSMutableArray *arrayOfStrings = [[[NSMutableArray alloc] init] autorelease];
//    NSString *childNodeString = [[self getChildNodeString] retain];
//    for (int k =0; k < leftArray.count; k++) {
//        for (int m = 0; m < rightArray.count; m++) {
//            NSString *resultString = [[NSString alloc] initWithFormat:@"%@,%@,%@",childNodeString, leftArray[k], rightArray[m]];
//            [arrayOfStrings addObject:resultString];
//            [resultString release];
//        }
//    }
//    [childNodeString release];
//    [leftArray release];
//    [rightArray release];
//    return arrayOfStrings;
//}
//
//
//- (NSString*) getRootNodeString {
//    return [[[NSString alloc] initWithString:@"0"] autorelease];
//}
//- (NSString*) getChildNodeString {
//    return [[[NSString alloc] initWithString:@"0,0"] autorelease];
//}
//- (NSString*) getNullChildString {
//    return [[[NSString alloc] initWithString:@"null,null"] autorelease];
//}
//
//- (void)dealloc {
//    [super dealloc];
//}



//- (NSArray *) arrayOfStringsForNodesCount: (NSUInteger) count {
//    NSMutableArray *arrayOfStrings = [[[NSMutableArray alloc] init] autorelease];
//    if (count == 0) {
//        NSString *nullNodeString = [[NSString alloc] initWithFormat:@"null,null"];
//        [arrayOfStrings addObject:nullNodeString];
//        [nullNodeString release];
//    }
//    else {
//        count-=2;
//        NSInteger i;
//        NSInteger j;
//        for (i = count, j=0; i <= count; i-=2, j+=2) {
//            NSArray *leftArrayOfStrings = [[self arrayOfStringsForNodeCount:i] retain];
//            NSArray *rightArrayOfStrings = [[self arrayOfStringsForNodeCount:j] retain];
//
//            for (int k =0; k < leftArrayOfStrings.count; k++) {
//                for (int m = 0; m < rightArrayOfStrings.count; m++) {
//                    NSString *resultString = [[NSString alloc] initWithFormat:@"0,0,%@,%@", leftArrayOfStrings[k], rightArrayOfStrings[m]];
//                    [arrayOfStrings addObject:resultString];
//                    [resultString release];
//                }
//            }
//            [leftArrayOfStrings release];
//            [rightArrayOfStrings release];
//        }
//    }
//    return arrayOfStrings;
//}

//- (NSString *)stringForNodeCount:(NSInteger)count {
//
//    NSCharacterSet *nullSet = [NSCharacterSet characterSetWithCharactersInString:@",null"];
//    NSMutableString *bTString = [[[NSMutableString alloc] init] autorelease];
//    [bTString appendFormat:@"["];
//    if(count % 2 != 0) {
//        count-=1;
//        NSString *rootString = [[NSString alloc] initWithString:@"0"];
//        NSArray *arrayOfNodesStrings = [self arrayOfStringsForNodeCount:count];
//        for (int i =0; i < arrayOfNodesStrings.count; i++) {
//            NSString *nodeString = [arrayOfNodesStrings[i] stringByTrimmingCharactersInSet:nullSet];
//            [bTString appendFormat:@"[%@%@%@]",rootString,([nodeString isEqualToString:@""] ? @"": @","), nodeString];
//        }
//        [rootString release];
//    }
//    [bTString appendFormat:@"]"];
//    NSLog(@"%@", bTString);
//    return bTString;
//}
@end
