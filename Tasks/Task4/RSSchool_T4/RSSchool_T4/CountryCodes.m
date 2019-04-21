//
//  CountryCodes.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "CountryCodes.h"

@interface CountryCodes()
@property (nonatomic, retain, readwrite) NSDictionary *countries;
@end

@implementation CountryCodes

- (instancetype)init
{
    self = [super init];
    if (self) {
        _countries = [[NSDictionary alloc] initWithDictionary:
                      @{
                        @"7":[[[CountryDescription alloc] initWithLength:10 andCode:7 andCountry:@"RU"] autorelease],
                        @"77":[[[CountryDescription alloc] initWithLength:10 andCode:7 andCountry:@"KZ"] autorelease],
                        @"373":[[[CountryDescription alloc] initWithLength:8 andCode:373 andCountry:@"MD"] autorelease],
                        @"374":[[[CountryDescription alloc] initWithLength:8 andCode:374 andCountry:@"AM"] autorelease],
                        @"375":[[[CountryDescription alloc] initWithLength:9 andCode:375 andCountry:@"BY"] autorelease],
                        @"380":[[[CountryDescription alloc] initWithLength:9 andCode:380 andCountry:@"UA"] autorelease],
                        @"992":[[[CountryDescription alloc] initWithLength:9 andCode:992 andCountry:@"TJ"] autorelease],
                        @"993":[[[CountryDescription alloc] initWithLength:8 andCode:993 andCountry:@"TM"] autorelease],
                        @"994":[[[CountryDescription alloc] initWithLength:9 andCode:994 andCountry:@"AZ"] autorelease],
                        @"996":[[[CountryDescription alloc] initWithLength:9 andCode:996 andCountry:@"KG"] autorelease],
                        @"998":[[[CountryDescription alloc] initWithLength:9 andCode:998 andCountry:@"UZ"] autorelease]
                        }];
    }
    return self;
}

- (nullable CountryDescription*) getCountryDescriptionByCode: (NSString*) code {
    [code retain];
    CountryDescription *countryDescriprtion = [[self.countries objectForKey:code] retain] ;
    [code release];
    return countryDescriprtion;
}

- (nullable CountryDescription*) searchCountryByString: (NSString*) searchString {
    [searchString retain];
    NSInteger count = searchString.length > 3 ? 3 : searchString.length;
    CountryDescription *countryDescription = nil;
    for (int i = 0; i < count; i++) {
        NSString *key = [[searchString substringWithRange:NSMakeRange(0, i+1)] retain];
        if ([self getCountryDescriptionByCode:key]) {
             countryDescription = [[[self getCountryDescriptionByCode:key] retain] autorelease];
        }
        [key release];
    }
    [searchString release];
    return countryDescription;
}

- (void)dealloc {
    [_countries release];
    [super dealloc];
}

@end
