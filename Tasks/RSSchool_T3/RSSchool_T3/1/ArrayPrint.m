#import "ArrayPrint.h"

@implementation NSString (RSSchool_Extension_Name)
- (NSString *) toString {
    return [NSString stringWithFormat:@"\"%@\"", self];
}
@end
@implementation NSNumber (RSSchool_Extension_Name)
- (NSString *) toString {
    return self.stringValue;
}
@end
@implementation NSNull (RSSchool_Extension_Name)
- (NSString *) toString {
    return @"null";
}
@end
@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print {
    return [self toString];
}

- (NSString *) toString {
    __block NSMutableString *desc = [[[NSMutableString alloc] init] autorelease];
    [desc appendFormat:@"["];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx >0) {
            [desc appendFormat:@","];
        }
        if ([obj conformsToProtocol:@protocol(PrintableProtocol)]){
            [desc appendString:[obj toString]];
        }
        else {
            [desc appendString:@"unsupported"];
        }
    }];
    [desc appendFormat:@"]"];
    return desc;
}

@end
