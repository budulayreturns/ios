//
//  CountryDescription.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/20/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "CountryDescription.h"

@implementation CountryDescription
- (instancetype)initWithLength: (NSInteger) length andCode: (NSInteger) code andCountry: (NSString*) country
{
    self = [super init];
    if (self) {
        _length = length;
        _code = code;
        [country retain];
        _country = [[NSString alloc] initWithString:country];
        [country release];
    }
    return self;
}

- (void)dealloc
{
    //_length = nil;
    //_code = nil;
    [_country release];
    _country = nil;
    [super dealloc];
}
@end
