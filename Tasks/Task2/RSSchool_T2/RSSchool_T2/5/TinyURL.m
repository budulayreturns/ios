#import "TinyURL.h"

/* There are 3 implementations of encoding and decoding
 
 1. Based on NSMutableOrderedSet, storing in it and then converting Base10 index to Base62 value (Current)
 2. Based on NSMapTable, generating a random number and stroing it in the NSMapTable
 3. Based on Base64 encoding and decoding, no storage was used, links may be longer then initial.
 */

//Implementation based on storage of random keys in NSMapTable

//@interface TinyURL()
//@property (nonatomic, retain, readwrite) NSMapTable<NSString*, NSString*> *urlMap;
//@property (nonatomic, retain, readonly,) NSURL *baseURL;
//@end

//@implementation TinyURL
//
//
//- (NSInteger) randomNumberWithIndex: (NSInteger) index {
//    return random() % index;
//}
//
//- (NSString*) getEncodedStringWithKey: (NSString*) keyString andLength: (NSInteger) length {
//    [keyString retain];
//    NSMutableString *encodedString = [[[NSMutableString alloc]init] autorelease];
//    NSInteger value = 0;
//    for (int i =0; i < length; i++) {
//        value = [self randomNumberWithIndex:keyString.length];
//        [encodedString appendFormat:@"%@", [keyString substringWithRange:NSMakeRange(value, 1)]];
//    }
//    [keyString release];
//    return  encodedString;
//}
//- (NSURL *)encode:(NSURL *)originalURL {
//    [originalURL retain];
//
//    NSInteger length = 6;
//    NSString * originalURLString = [[NSString alloc] initWithString:[originalURL absoluteString]];
//    NSString *stringBase62 = [[NSString alloc] initWithString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
//
//    NSString *encodedString;
//    NSInteger i = 0;
//
//    do {
//        if (i>100) {
//            length+=1;
//            i=0;
//        }
//        encodedString = [self getEncodedStringWithKey:stringBase62 andLength:length];
//        i+=1;
//    }
//    while ([self.urlMap objectForKey:encodedString]);
//
//    NSLog(@"%@", encodedString);
//    [self.urlMap setObject:originalURLString forKey:encodedString];
//    NSURL *encodedURL = [self.baseURL URLByAppendingPathComponent:encodedString];
//
//    [originalURLString release];
//    [stringBase62 release];
//    [originalURL release];
//    return encodedURL;
//}
//
//- (NSURL *)decode:(NSURL *)shortenedURL {
//
//    [shortenedURL retain];
//    NSString *encodedString = [[shortenedURL path] substringFromIndex:1];
//    NSString *decodedURLString = [self.urlMap objectForKey:encodedString];
//
//    NSURL *decodedURL = [[[NSURL alloc] initWithString:decodedURLString] autorelease];
//    NSLog(@"Decoded string: %@", decodedURLString);
//
//    [shortenedURL release];
//    return decodedURL;
//}
//
//- (instancetype)init{
//    if (self = [super init]) {
//        _urlMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsStrongMemory capacity:1];
//        _baseURL = [[NSURL alloc] initWithString:@"https://u.rl/"];
//    }
//    return self;
//}
//- (void)deallocc {
//    [_baseURL release];
//    [_urlMap release];
//    [super dealloc];
//}
//@end

//Implementation based on Base64 encoding and decoding ,No storage

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


@interface TinyURL()
@property (nonatomic, retain, readwrite) NSMutableOrderedSet *urlMap;
@property (nonatomic, copy) NSString *stringBase62;
@property (nonatomic, retain, readonly,) NSURL *baseURL;
@end

@implementation TinyURL

- (NSString *) convertBase10ToBase62: (NSInteger) value {
    NSMutableString *encodedString = [[[NSMutableString alloc] init] autorelease];
    NSInteger index = 0;
    while (value > 0) {
        index = value % self.stringBase62.length;
        [encodedString insertString:[self.stringBase62 substringWithRange:NSMakeRange(index-1, 1)] atIndex:0];
        value /= self.stringBase62.length;
    }
    return encodedString;
}

- (NSInteger) convertBase62ToBase10: (NSString*) encodedString {
    [encodedString retain];
    __block NSInteger rank = 0;
    __block NSInteger resultIndex = 0;
    [encodedString enumerateSubstringsInRange:NSMakeRange(0, encodedString.length) options:NSStringEnumerationByComposedCharacterSequences | NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:substring];
        NSInteger index = [self.stringBase62 rangeOfCharacterFromSet:charSet].location+1;
        resultIndex += index*pow(self.stringBase62.length, rank);
        rank+=1;
    }];
    [encodedString release];
    return resultIndex;
}

- (NSURL *)encode:(NSURL *)originalURL {
    
    [originalURL retain];
    NSString * originalURLString = [[NSString alloc] initWithString:[originalURL absoluteString]];
    [self.urlMap addObject:originalURLString];
    NSInteger linkIndex = [self.urlMap indexOfObject:originalURLString]+1;
    NSString *encodedString = [[self convertBase10ToBase62:linkIndex] copy];
    NSURL *encodedURL = [[[self.baseURL URLByAppendingPathComponent:encodedString]copy] autorelease];
    [originalURL release];
    [encodedString release];
    [originalURLString release];
    return encodedURL;
}
    
- (NSURL *)decode:(NSURL *)shortenedURL {
    [shortenedURL retain];
    NSString *encodedString = [[[shortenedURL path] substringFromIndex:1]copy];
    NSInteger result = [self convertBase62ToBase10:encodedString];
    if (self.urlMap.count<result-1) {
        NSURL *decodedURL = [[[self.baseURL URLByAppendingPathComponent:@"404"]copy] autorelease];
        return decodedURL;
    }
    NSString *decodedURLString = [[NSString alloc] initWithString: [self.urlMap objectAtIndex:result-1]];
    NSURL *decodedURL = [[[NSURL alloc] initWithString:decodedURLString] autorelease];
    [encodedString release];
    [decodedURLString release];
    [shortenedURL release];
    return decodedURL;
}

- (instancetype)init{
    if (self = [super init]) {
        _urlMap = [[NSMutableOrderedSet alloc] init];
        _baseURL = [[NSURL alloc] initWithString:@"https://u.rl/"];
        _stringBase62 =[[NSString alloc] initWithString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
    }
    return self;
}
- (void)deallocc {
    [_stringBase62 release];
    [_baseURL release];
    [_urlMap release];
    [super dealloc];
}
@end



