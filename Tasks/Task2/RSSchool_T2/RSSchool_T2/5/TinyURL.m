#import "TinyURL.h"


/*
 URL shortening services like tinyurl.com or vk.cc allow you to enter a URL
 such as https://drive.google.com/file/d/1EBGP1ntXPGVSfYyKGenOdzgh_hna4vg4/view
 and get back a short one such as https://vk.cc/9dEj5S
 
 Design the encode and decode methods for the TinyURL service.
 There is no restriction on how your encode/decode algorithm should work.
 You just need to ensure that a URL can be encoded to a tiny URL
 and the tiny URL can be decoded to the original URL.
 */

//    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[] ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//
//    NSString *url = [originalURL absoluteString];
//    NSString *encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//


//public static class Base36Converter
//{
//    private const int Base = 36;
//    private const string Chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//
//    public static string ConvertTo(int value)
//    {
//        string result = "";
//
//        while (value > 0)
//        {
//            result = Chars[value % Base] + result; // use StringBuilder for better performance
//            value /= Base;
//        }
//
//        return result;
//    }
//}


//[originalURL retain];
//NSString *percentEncodedString = [[originalURL absoluteString] stringByRemovingPercentEncoding];
//
////NSCharacterSet *allowedCharacters = [NSCharacterSet URLPathAllowedCharacterSet];
//NSData *plainData = [[originalURL absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
//
//NSString *baseURL = [[NSString alloc] initWithFormat:@"https://u.rl/"];
//
////NSString *encodedString = [[plainData base64EncodedStringWithOptions:kNilOptions] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//
//NSString *result = [baseURL stringByAppendingString:encodedString];
//NSURL *encodedURL = [[[NSURL alloc] initWithString:result] autorelease];
@implementation TinyURL


- (NSURL *)encode:(NSURL *)originalURL {
    
    [originalURL retain];
    //NSString *percentDecodedString = [[originalURL absoluteString] stringByRemovingPercentEncoding];
    NSData *plainData = [[originalURL absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = [[NSString alloc] initWithFormat:@"https://u.rl/"];
    NSString *encodedString = [plainData base64EncodedStringWithOptions:kNilOptions];
    NSString *result = [baseURL stringByAppendingString:encodedString];
    NSURL *encodedURL = [[[NSURL alloc] initWithString:result] autorelease];
    
    NSLog(@"Encoded string: %@", encodedString);
    [baseURL release];
    [originalURL release];
    return encodedURL;
}

- (NSURL *)decode:(NSURL *)shortenedURL {
    
    [shortenedURL retain];
    NSString *encodedString = [[shortenedURL path] substringFromIndex:1];
    NSData *plainData = [[NSData alloc] initWithBase64EncodedString:encodedString options:kNilOptions];
    NSString *decodedString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    //NSCharacterSet *allowedCharacters = [NSCharacterSet URLPathAllowedCharacterSet];
    //NSString *percentEncodedString = [decodedString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    NSURL *decodedURL = [[[NSURL alloc] initWithString:decodedString] autorelease];
    
    NSLog(@"Decoded string: %@", decodedString);
    
    [shortenedURL release];
    [plainData release];
    [decodedString release];
    return decodedURL;
}
@end
