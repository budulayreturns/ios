//
//  UITextField+RSSchool_T4_Extension.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/18/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (RSSchool_T4_Extension)
- (void) addBorder;
- (void) setImageForLeftView: (nullable UIImage*) image;
//- (void) appendPlusToText;
//- (void) removePlusFromText;
- (NSInteger) countNumbersInText;
@end

NS_ASSUME_NONNULL_END
