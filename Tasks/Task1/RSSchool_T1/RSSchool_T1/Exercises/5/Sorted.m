#import "Sorted.h"

@implementation ResultObject

- (void)dealloc {
    
    if(_detail) {
        [_detail release];
    }
    [super dealloc];
}

@end

@implementation Sorted

- (BOOL)checkSortable:(NSUInteger)singular checkPair:(NSUInteger)pair checkSequence:(NSUInteger)sequence {
    
    if (singular >2 || pair > 1 || sequence > 1) {
       return NO;
    }
    else return YES;
}

- (BOOL) compareElementsIn: (NSArray *) array withElementAt: (NSUInteger) index1 andElementAt: (NSUInteger) index2 {
    [array retain];
    BOOL sorted = YES;
    if (index1 != 0){
        if([array[index2] integerValue] < [array[index1 - 1] integerValue]){
            sorted = NO;
        }
    }
    if (index2 != array.count-1){
        if([array[index1] integerValue] > [array[index2 + 1] integerValue]){
            sorted = NO;
        }
    }
    [array release];
    return sorted;
}


- (NSDictionary*) checkSortingIn:(NSArray *)mainArray withArray:(NSMutableArray *)indexArray {
    
    [mainArray retain];
    [indexArray retain];
    
    NSUInteger indexes = indexArray.count;
    NSInteger index1 =0;
    NSInteger index2 =0;
    
    BOOL result = NO;
    
    if (indexes > 0) {
        if (indexes == 1) {
            
            index1 = [indexArray[0][0] integerValue];
            index2 = [indexArray[0][1] integerValue];
            result = [self compareElementsIn:mainArray withElementAt:index1 andElementAt:index2];
        }
        else {
            index1 = [indexArray[0][0] integerValue];
            index2 = [indexArray[1][1] integerValue];
            result = [self compareElementsIn:mainArray withElementAt:index1 andElementAt:index2];
        }
    }
    else {
        result = YES;
    }
    NSString * val = [[[NSString alloc] initWithFormat:@"%ld %ld", index1+1, index2+1] autorelease];
    NSString *key = [[[NSString alloc] initWithFormat:@"%s", result ? "YES":"NO"] autorelease];
    NSDictionary *dict = @{key:val};
    
    [mainArray release];
    return dict;
}

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    
    [string retain];
    ResultObject *value = [[ResultObject new] autorelease];
    
    NSUInteger sequence = 0;
    NSUInteger countSingularAnomaly = 0;
    NSUInteger countPairAnomaly = 0;
    NSUInteger countSequenceAnomaly = 0;
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSMutableArray *singularAnomaly = [NSMutableArray new];
    NSMutableArray *pairAnomaly = [NSMutableArray new];
    NSMutableArray *sequenceAnomaly = [NSMutableArray new];
    
    BOOL isUnsortable = NO;
    
    for (int i = 0; i < array.count-1; i++) {
       
        @autoreleasepool {
        
        if (![self checkSortable:countSingularAnomaly checkPair:countPairAnomaly checkSequence:countSequenceAnomaly]) { //проверить
            isUnsortable = YES;
            break;
        }
        
        if ([array[i] integerValue] > [array [i+1] integerValue]) {
            sequence++;
            if (sequence == 1){
                countSingularAnomaly++;
                
                NSArray *arr = @[[NSNumber numberWithInt:i], [NSNumber numberWithInt:i+1]];
                [singularAnomaly addObject:arr];
                
                
            }
            else if (sequence == 2){
                countSingularAnomaly--;
                countPairAnomaly++;
                NSArray *arr = @[singularAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [singularAnomaly removeLastObject];
                [pairAnomaly addObject:arr];
                
                
            }
            else if (sequence == 3){
                countPairAnomaly--;
                countSequenceAnomaly++;
                NSArray *arr = @[pairAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [pairAnomaly removeLastObject];
                [sequenceAnomaly addObject:arr];
               
                
            }
            else if (sequence > 3) {
                NSArray *arr = @[sequenceAnomaly.lastObject[0], [NSNumber numberWithInt:i+1]];
                [pairAnomaly removeLastObject];
                [sequenceAnomaly addObject:arr];
                
            }
        }
        else {
            sequence = 0;
        }
        }
    }
    
    
    if (countSingularAnomaly == 0 && countPairAnomaly == 0 && countSequenceAnomaly == 0) {
        value.status = YES;
    }
    else {
        NSDictionary *singularAnomalyDict = [self checkSortingIn:array withArray:singularAnomaly];
        NSDictionary *pairAnomalyDict = [self checkSortingIn:array withArray:pairAnomaly];
        NSDictionary* sequenceAnomalyDict = [self checkSortingIn:array withArray:sequenceAnomaly];
        
        
        if ([singularAnomalyDict.allKeys.firstObject boolValue] == NO || [pairAnomalyDict.allKeys.firstObject boolValue] == NO || [sequenceAnomalyDict.allKeys.firstObject boolValue] == NO) {
            isUnsortable = YES;
        }
        
        if (isUnsortable) {
            value.status = NO;
        }
        else {
            
            if (countSingularAnomaly>0&&countPairAnomaly==0&&countSequenceAnomaly==0){
                value.status = YES;
                value.detail = [[[NSString alloc] initWithFormat:@"swap %@", singularAnomalyDict.allValues.firstObject] autorelease];
            }
            else if (countSingularAnomaly==0&&countPairAnomaly>0&&countSequenceAnomaly==0){
                value.status = YES;
                value.detail = [[[NSString alloc] initWithFormat:@"swap %@", pairAnomalyDict.allValues.firstObject] autorelease];
            }
            else if (countSingularAnomaly==0&&countPairAnomaly==0&&countSequenceAnomaly>0){
                value.status = YES;
                value.detail = [[[NSString alloc] initWithFormat:@"reverse %@", sequenceAnomalyDict.allValues.firstObject] autorelease];
            }
            else {
                value.status = NO;
            }
        }
       
    
    }
    [singularAnomaly release];
    [pairAnomaly release];
    [sequenceAnomaly release];
    [string release];
   
    return value;
}


@end
