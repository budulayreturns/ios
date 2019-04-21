//
//  NSString+RSSchool_T4_Extension.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RSSchool_T4_Extension)
- (NSInteger) rs_containsNumericCharacters;
- (BOOL) rs_containsSpecialCharacters;
- (NSString*) rs_getNumbersFromString;
- (NSString*) rs_appendPlusPrefix;
+ (NSString *) rs_formatPhoneNumber: (NSString*) number withFormat: (NSString*) format andCodeLength:(NSInteger) codeLength;
@end

NS_ASSUME_NONNULL_END
