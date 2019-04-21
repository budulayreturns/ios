//
//  UITextField+RSSchool_T4_Extension.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/18/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (RSSchool_T4_Extension)
- (void) rs_addBorder;
- (void) rs_setImageForLeftView: (nullable UIImage*) image;
@end

NS_ASSUME_NONNULL_END
