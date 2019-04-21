//
//  UITextField+RSSchool_T4_Extension.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/18/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "UITextField+RSSchool_T4_Extension.h"

@implementation UITextField (RSSchool_T4_Extension)

- (void) rs_addBorder {
    self.layer.cornerRadius = 6.f;
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 1.f;
}

- (void) rs_setImageForLeftView: (nullable UIImage*) image {
    if (self.leftViewMode != UITextFieldViewModeAlways) {
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    [image retain];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imageView.image = image;
    self.leftView = imageView;
    [imageView release];
    [image release];
}
@end

