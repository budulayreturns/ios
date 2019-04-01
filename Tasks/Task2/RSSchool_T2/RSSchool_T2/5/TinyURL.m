#import "TinyURL.h"

//Implementation based on Base64Encoding

//@implementation TinyURL
//
//
//- (NSURL *)encode:(NSURL *)originalURL {
//
//    [originalURL retain];
//    //NSString *percentDecodedString = [[originalURL absoluteString] stringByRemovingPercentEncoding];
//    NSData *plainData = [[originalURL absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *baseURL = [[NSString alloc] initWithFormat:@"https://u.rl/"];
//    NSString *encodedString = [plainData base64EncodedStringWithOptions:kNilOptions];
//    NSString *result = [baseURL stringByAppendingString:encodedString];
//    NSURL *encodedURL = [[[NSURL alloc] initWithString:result] autorelease];
//
//    NSLog(@"Encoded string: %@", encodedString);
//    [baseURL release];
//    [originalURL release];
//    return encodedURL;
//}
//
//- (NSURL *)decode:(NSURL *)shortenedURL {
//
//    [shortenedURL retain];
//    NSString *encodedString = [[shortenedURL path] substringFromIndex:1];
//    NSData *plainData = [[NSData alloc] initWithBase64EncodedString:encodedString options:kNilOptions];
//    NSString *decodedString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
//    //NSCharacterSet *allowedCharacters = [NSCharacterSet URLPathAllowedCharacterSet];
//    //NSString *percentEncodedString = [decodedString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//
//    NSURL *decodedURL = [[[NSURL alloc] initWithString:decodedString] autorelease];
//
//    NSLog(@"Decoded string: %@", decodedString);
//
//    [shortenedURL release];
//    [plainData release];
//    [decodedString release];
//    return decodedURL;
//}
//@end


//Implementation based on storage of random keys in NSMapTable
@interface TinyURL()
@property (nonatomic, retain, readwrite) NSMapTable<NSString*, NSString*> *urlMap;
@end


@implementation TinyURL


- (NSInteger) randomNumberWithIndex: (NSInteger) index {
    return random() % index;
}

- (NSString*) getEncodedStringWithKey: (NSString*) keyString andLength: (NSInteger) length {
    [keyString retain];
    NSMutableString *encodedString = [[[NSMutableString alloc]init] autorelease];
    NSInteger value = 0;
    for (int i =0; i < length; i++) {
        value = [self randomNumberWithIndex:keyString.length];
        [encodedString appendFormat:@"%@", [keyString substringWithRange:NSMakeRange(value, 1)]];
    }
    [keyString release];
    return  encodedString;
}


- (NSURL *)encode:(NSURL *)originalURL {
    
    [originalURL retain];

    NSInteger length = 6;
    NSString * originalURLString = [[NSString alloc] initWithString:[originalURL absoluteString]];
    NSString *stringBase62 = [[NSString alloc] initWithString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    
    NSString *encodedString;
    NSInteger i = 0;
    do {
        if (i>100) {
            length+=1;
            i=0;
        }
        encodedString = [self getEncodedStringWithKey:stringBase62 andLength:length];
        i+=1;
    }
    while ([self.urlMap objectForKey:encodedString]);
    
    NSLog(@"%@", encodedString);
    [self.urlMap setObject:originalURLString forKey:encodedString];
    NSURL *encodedURL = [self.baseURL URLByAppendingPathComponent:encodedString];

    [originalURLString release];
    [stringBase62 release];
    [originalURL release];
    return encodedURL;
}
    
- (NSURL *)decode:(NSURL *)shortenedURL {
    
    [shortenedURL retain];
    NSString *encodedString = [[shortenedURL path] substringFromIndex:1];
    NSString *decodedURLString = [self.urlMap objectForKey:encodedString];
    
    NSURL *decodedURL = [[[NSURL alloc] initWithString:decodedURLString] autorelease];
    NSLog(@"Decoded string: %@", decodedURLString);
    
    [shortenedURL release];
    return decodedURL;
}

- (instancetype)init{
    if (self = [super init]) {
        _urlMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsStrongMemory capacity:1];
        _baseURL = [[NSURL alloc] initWithString:@"https://u.rl/"];
    }
    return self;
}
- (void)deallocc {
    [_baseURL release];
    [_urlMap release];
    [super dealloc];
}
@end



//    NSError *error;
//    NSRegularExpression *regExp1 = [NSRegularExpression regularExpressionWithPattern:@"((ftp|http|https)://)?" options:NSRegularExpressionCaseInsensitive error:&error];
//     NSRegularExpression *regExp2 = [NSRegularExpression regularExpressionWithPattern:@"\\w+" options:NSRegularExpressionCaseInsensitive error:&error];
//
//    NSMutableString *originalURLString = [[originalURL absoluteString] mutableCopy];
//    [regExp1 replaceMatchesInString:originalURLString options:0 range:NSMakeRange(0, originalURLString.length) withTemplate:@""];
//
//    __block NSMutableString *clearedString = [[NSMutableString alloc] init];
//    [regExp2 enumerateMatchesInString:originalURLString options:0 range:NSMakeRange(0, originalURLString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        [clearedString appendString:[[originalURLString substringWithRange:[result range]]lowercaseString]];
//    }];
//
//    __block NSMutableString *decodedString = [[NSMutableString alloc]init];
//
//    [clearedString enumerateSubstringsInRange:NSMakeRange(0, clearedString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//
//        NSString *s = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)[stringBase36 rangeOfString:substring].location];
//        [decodedString insertString:s atIndex:0];
//        [s release];
//    }];
//
//    NSMutableString *encodedString = [[NSMutableString alloc]init];
//
//    NSInteger value = [decodedString integerValue];
//    while (value > 0)
//    {
//        NSInteger i = value % stringBase62.length;
//
//        NSString *str= [stringBase62 substringWithRange:NSMakeRange(i, 1)];
//        [encodedString insertString:str atIndex:0];
//        value /= stringBase62.length;
//    }
  
    //NSString *percentDecodedString = [[originalURL absoluteString] stringByRemovingPercentEncoding];
//    NSData *plainData = [[originalURL absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *baseURL = [[NSString alloc] initWithFormat:@"https://u.rl/"];
//    NSString *encodedString = [plainData base64EncodedStringWithOptions:kNilOptions];
//    NSString *result1 = [baseURL stringByAppendingString:encodedString];
//    NSURL *encodedURL = [[[NSURL alloc] initWithString:result1] autorelease];
//
//    NSLog(@"Encoded string: %@", encodedString);
//    [baseURL release];





