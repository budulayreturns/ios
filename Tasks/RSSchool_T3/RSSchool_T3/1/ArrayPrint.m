#import "ArrayPrint.h"

@implementation NSString (RSSchool_Extension_Name)
- (NSString *) toString {
    NSString *string = [[[NSString alloc] initWithFormat:@"\"%@\"", self]autorelease];
    return string;
}
@end
@implementation NSNumber (RSSchool_Extension_Name)
- (NSString *) toString {
    NSString *string = [[[NSString alloc] initWithFormat:@"%@", self.stringValue] autorelease];
    return string;
}
@end
@implementation NSNull (RSSchool_Extension_Name)
- (NSString *) toString {
    NSString *string = [[[NSString alloc] initWithFormat:@"null"] autorelease];
    return string;
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
