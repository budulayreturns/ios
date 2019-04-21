//
//  CountryCodes.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryDescription.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryCodes : NSObject
@property (nonatomic, retain, readonly) NSDictionary *countries;
- (nullable CountryDescription *) searchCountryByString: (NSString*) searchString;
- (nullable CountryDescription*) getCountryDescriptionByCode: (NSString*) code;
@end

NS_ASSUME_NONNULL_END
