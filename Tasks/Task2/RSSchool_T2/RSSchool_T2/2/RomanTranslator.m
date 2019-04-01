#import "RomanTranslator.h"


@implementation RomanTranslator

- (instancetype) init {
    if (self = [super init]){
        _romanDict = @{
                      @1: @"I",
                      @5: @"V",
                      @10:@"X",
                      @50:@"L",
                      @100:@"C",
                      @500:@"D",
                      @1000:@"M"
                      };
        _arabicDict = @{
                        @"I":@1,
                        @"V":@5,
                        @"X":@10,
                        @"L":@50,
                        @"C":@100,
                        @"D":@500,
                        @"M":@1000
                       };
    }
    return self;
}

- (NSString*) getRomanDigitiWithArabic: (NSInteger) number andRank: (NSInteger) rank {
    NSInteger value = pow(10, rank);
    NSInteger key = number * value;
    NSString *string = [self.romanDict objectForKey:[NSNumber numberWithInteger:key]];
    NSMutableString * mutString = [[NSMutableString alloc] init];
    
    if (!string){
        if (number <= 4) {
            if (number == 4) {
                [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:1*value]]];
                [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:5*value]]];
            }
            else {
                for (int i = 0; i < number; i++) {
                    [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:1*value]]];
                }
            }
        }
        else if(number > 5 && number <= 9) {
            
            if (number == 9){
                [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:1*value]]];
                [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:10*value]]];
            }
            else {
                [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:5*value]]];
                for (int i = 0; i < number-5; i++) {
                    [mutString appendString:[self.romanDict objectForKey:[NSNumber numberWithInteger:1*value]]];
                }
            }
        }
        return [mutString autorelease];
    }
    else {
        [mutString release];
        return [string autorelease];
        }
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    [arabicString retain];
    NSInteger value = [arabicString integerValue];
    
    if (value <= 0&& value > 3999) {
        return [[[NSString alloc] initWithFormat:@"Invalid value!"] autorelease];
    }
    
    __block NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
    __block NSInteger idx = 0;
    [arabicString enumerateSubstringsInRange:NSMakeRange(0, arabicString.length) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSInteger number = [substring integerValue];
        [result insertString:[self getRomanDigitiWithArabic:number andRank:idx] atIndex:0];
        idx+=1;
        NSLog(@" %@", substring);
        }];
    NSLog(@" %@", result);
    [arabicString release];
    return result;
}

- (NSInteger) getArabicDigitiWithRoman:(NSString*)number {
    [number retain];
    NSInteger result = [[self.arabicDict objectForKey:number] integerValue];
    [number release];
    return result;
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    [romanString retain];
    if (romanString.length == 0) {
        return [[[NSString alloc] initWithFormat:@"Invalid value!"] autorelease];
    }
    __block NSInteger sum = 0;
    __block NSInteger prevValue = [[self.arabicDict objectForKey:@"M"] integerValue];
    [romanString enumerateSubstringsInRange:NSMakeRange(0, romanString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSInteger currentValue = [self getArabicDigitiWithRoman:substring];
        if (prevValue >= currentValue) {
            sum+=currentValue;
        }
        else {
            sum+=currentValue;
            sum-=prevValue*2;
        }
        prevValue = currentValue;
        NSLog(@" %@", substring);
    }];
    
    NSString *result = [[[NSString alloc] initWithFormat:@"%ld", (long)sum] autorelease];
    NSLog(@" %@", result);
    [romanString release];
    return result;
}

-(void)dealloc {
    [_romanDict release];
    [_arabicDict release];
    [super dealloc];
}

@end
