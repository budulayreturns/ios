#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

- (BOOL)checkSortable:(NSUInteger)singular checkPair:(NSUInteger)pair checkSequence:(NSUInteger)sequence {
    
    if (singular >2 || pair > 1 || sequence > 1) {
       return NO;
    }
    else return YES;
}

- (BOOL) compareElementsIn: (NSArray *) array withElementAt: (NSUInteger) index1 andElementAt: (NSUInteger) index2 {
    
    BOOL sorted = YES;
    if (index1 != 0){
        if([array[index2] integerValue] < [array[index1 - 1] integerValue]){
            sorted = NO;
        }
    }
    if (index2 != array.count){
        if([array[index1] integerValue] > [array[index2 + 1] integerValue]){
            sorted = NO;
        }
    }
    return sorted;
}

- (NSString*) getDetails {
    
    return @"";
}

- (NSUInteger) checkSortingIn:(NSArray *)mainArray withArray:(NSMutableArray *)indexArray {
    
    
    NSUInteger indexes = indexArray.count;
    NSUInteger unsolvedAnomaly = 0;
    BOOL result = NO;
    
    if (indexes > 0) {
        if (indexes == 1) {
            
            result = [self compareElementsIn:mainArray withElementAt:[indexArray[0][0] integerValue] andElementAt:[indexArray[0][1] integerValue]];
        }
        else {
            result = [self compareElementsIn:mainArray withElementAt:[indexArray[0][0] integerValue] andElementAt:[indexArray[1][1] integerValue]];
        }
    }
    if (!result) {
        unsolvedAnomaly++;
    }
    return unsolvedAnomaly;
}

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    
    NSUInteger sequence = 0;
    
    NSUInteger unsolvedSingularAnomaly = 0;
    NSUInteger unsolvedPairAnomaly = 0;
    NSUInteger unsolvedSequenceAnomaly = 0;
    
    NSUInteger countSingularAnomaly = 0;
    NSUInteger countPairAnomaly = 0;
    NSUInteger countSequenceAnomaly = 0;
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSMutableArray *singularAnomaly = [NSMutableArray new];
    NSMutableArray *pairAnomaly = [NSMutableArray new];
    NSMutableArray *sequenceAnomaly = [NSMutableArray new];
    
    BOOL isUnsortable = NO;
    
    for (int i = 0; i < array.count-1; i++) {
        
        if (![self checkSortable:countSingularAnomaly checkPair:countPairAnomaly checkSequence:countSequenceAnomaly]) { //проверить
            isUnsortable = YES;
            break;
        }
        
        if ([array[i] integerValue] > [array [i+1] integerValue]) {
            sequence++;
            if (sequence == 1){
                countSingularAnomaly++;
                NSArray *array = @[[NSNumber numberWithInt:i], [NSNumber numberWithInt:i+1]];
                [singularAnomaly addObject:array];
            }
            else if (sequence == 2){
                countSingularAnomaly--;
                countPairAnomaly++;
                NSArray *array = @[singularAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [singularAnomaly removeLastObject];
                [pairAnomaly addObject:array];
            }
            else if (sequence == 3){
                countPairAnomaly--;
                countSequenceAnomaly++;
                NSArray *array = @[pairAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [pairAnomaly removeLastObject];
                [sequenceAnomaly addObject:array];
            }
            else if (sequence > 3) {
                NSArray *array = @[sequenceAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [pairAnomaly removeLastObject];
                [sequenceAnomaly addObject:array];
            }
        }
        else {
            sequence = 0;
        }
    }
    
    if (countSingularAnomaly == 0 && countPairAnomaly == 0 && countSequenceAnomaly == 0) {
        value.status = YES;
    }
    else {
        unsolvedSingularAnomaly = [self checkSortingIn:array withArray:singularAnomaly];
        unsolvedPairAnomaly = [self checkSortingIn:array withArray:pairAnomaly];
        unsolvedSequenceAnomaly = [self checkSortingIn:array withArray:sequenceAnomaly];
        
        if (unsolvedSingularAnomaly >= 1 || unsolvedPairAnomaly >= 1 || unsolvedSequenceAnomaly >= 1) {
            isUnsortable = YES;
        }
        
        if (isUnsortable) {
            value.status = NO;
        }
        else {
            
            if (countSingularAnomaly>0&&countPairAnomaly==0&&countSequenceAnomaly==0){
                
                [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
                
            }
            else if (countSingularAnomaly==0&&countPairAnomaly>0&&countSequenceAnomaly==0){
                
                
            }
            else if (countSingularAnomaly==0&&countPairAnomaly==0&&countSequenceAnomaly>0){
                
                
            }
            else {
                value.status = NO;
            }
        }
        
    }
    
    
    
    
//    BOOL isSwapFailed = YES;
//    BOOL isReverseFailed = YES;
//    NSInteger counter = 0;
//    NSInteger sequence = 0;
//    NSInteger sequenceStarted = 0;
//    NSInteger swapsComplete = 0;
//
//    for (int i = 0; i < array.count-1; i++) {
//
//        if (sequenceStarted > 1) {
//            break;
//        }
//        if (swapsComplete > 1) {
//            break;
//        }
//
//        if ([array[i] integerValue] > [array [i+1] integerValue]) {
//            sequence++;
//
//            if (sequence == 1){
//                startPos = i;
//                endPos = i+1;
//            }
//            else {
//                endPos = i+1;
//                if (sequence == 3) {
//                    sequenceStarted++;
//                    isReverseFailed = NO;
//                }
//            }
//        }
//        else if ([array[i] integerValue] < [array [i+1] integerValue]) {
//            sequence = 0;
//
//        }
//    }
//
//    if (sequenceStarted == 1) {
//        if (startPos != 0) {
//            if([array[startPos-1] integerValue]> [array[endPos]integerValue]){
//                isReverseFailed = YES;
//            }
//        }
//        if (endPos != array.count-1){
//            if([array[startPos] integerValue] > [array[endPos+1] integerValue]){
//                isReverseFailed = YES;
//            }
//        }
//    }
//    else if (sequenceStarted > 1){
//        isReverseFailed= YES;
//    }
//
//
//    if (isSwapFailed == NO) {
//        value.status = YES;
//        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
//    }
//    else if (isReverseFailed == NO){
//        value.status = YES;
//        value.detail = [[NSString alloc] initWithFormat:@"reverse %ld %ld", (long)startPos+1, (long)endPos+1];
//    }
////    else if (sequenceStarted==0&&swapsComplete==0){
////        value.status = YES;
////    }
//    else {
//        value.status = NO;
//    }
//
    
    
//    for (int i = 0; i < array.count-1; i++) {
//
//        if ([array[i] integerValue] > [array [i+1] integerValue]) {
//
//            counter++;
//            if (counter == 1) {
//                startPos = i;
//                endPos = i+1;
//                isSwap = YES;
//            }
//            else if (counter == 2) {
//                if (isSwap == NO) {
//
//                    endPos = i+1;
//                    if ([array[startPos] integerValue] > [array [i] integerValue]) {
//                        isSwap = YES;
//                    }
//                }
//                if (isSwap == YES) {
//                    isSwap = NO;
//                }
//            }
//            else if (counter > 2){
//
//
//
//            }
//        }
//        if ([array[i] integerValue] <= [array [i+1] integerValue]) {
//
//            if (isSwap == YES) {
//                if ([array[startPos] integerValue] >[array [i+1] integerValue]) {
//                    isSwap = NO;
//                }
//            }
//
//        }
//    }
//    if (counter == 0) {
//        value.status = YES;
//    }
//    else if (counter == 1&&isSwap==YES) {
//        value.status = YES;
//        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
//    }
//    else if (counter == 2&&isSwap==YES) {
//        value.status = YES;
//        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
//    }
//    else  {
//         value.status = NO;
//
//    }
    
//    else {
    //        value.status = YES;
    //        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPosition, (long)endPosition];
//    }
  
    return value;
}




@end
