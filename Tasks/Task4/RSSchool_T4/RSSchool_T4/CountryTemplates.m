//
//  CountryTemplates.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/20/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "CountryTemplates.h"

@interface CountryTemplates()
@property (nonatomic, retain, readwrite) NSDictionary *templates;
@end

@implementation CountryTemplates

- (instancetype)init
{
    self = [super init];
    if (self) {
        _templates = [[NSDictionary alloc] initWithDictionary:@{ @8:@"(xx) xxx-xxx",
                                                                 @9:@"(xx) xxx-xx-xx",
                                                                 @10:@"(xxx) xxx xx xx"}];
    }
    return self;
}

- (nullable NSString*) getTemplateByNumberLength: (NSInteger) length {
    return [[self.templates objectForKey:[NSNumber numberWithInteger:length]] autorelease];
}

- (void)dealloc
{
    [_templates release];
    _templates = nil;
    [super dealloc];
}
@end
