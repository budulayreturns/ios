//
//  PhoneTextField.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/21/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneTextField.h"

@implementation PhoneTextField
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        _limitOfNumbers = 12;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _limitOfNumbers = 12;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
