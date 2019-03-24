#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    
    NSInteger startPos = 0;
    NSInteger endPos = 0;
    
    NSInteger counter = 0;
    BOOL isSwap = NO;
    BOOL isReverse = NO;


    for (int i = 0; i < array.count-1; i++) {
        
        if ([array[i] integerValue] > [array [i+1] integerValue]) {
            
            counter++;
            if (counter == 1) {
                startPos = i;
                endPos = i+1;
                isSwap = YES;
            }
            else if (counter == 2) {
                if (isSwap == NO) {
                    
                    endPos = i+1;
                    if ([array[startPos] integerValue] > [array [i] integerValue]) {
                        isSwap = YES;
                    }
                }
                if (isSwap == YES) {
                    isSwap = NO;
                }
            }
            else if (counter > 2){
                
                
                
            }
        }
        if ([array[i] integerValue] <= [array [i+1] integerValue]) {
            
            if (isSwap == YES) {
                if ([array[startPos] integerValue] >[array [i+1] integerValue]) {
                    isSwap = NO;
                }
            }
            if (isReverse == YES) {
                
                //isReverse = NO;
            }
        }
    }
    if (counter == 0) {
        value.status = YES;
    }
    else if (counter == 1&&isSwap==YES) {
        value.status = YES;
        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
    }
    else if (counter == 2&&isSwap==YES) {
        value.status = YES;
        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPos+1, (long)endPos+1];
    }
    else  {
         value.status = NO;
        
    }
    
    
    
    
   
    
    
    
    
    
    
//    else {
    //        value.status = YES;
    //        value.detail = [[NSString alloc] initWithFormat:@"swap %ld %ld", (long)startPosition, (long)endPosition];
//    }
    NSLog(@"%ld", (long)counter);
    return value;
}




@end
