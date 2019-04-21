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
- (NSInteger) containsNumericCharacters;
- (NSString*) getNumbersFromString;
- (NSString*) appendPlusPrefix;
- (NSString*) removePlusPrefix;
@end

NS_ASSUME_NONNULL_END
