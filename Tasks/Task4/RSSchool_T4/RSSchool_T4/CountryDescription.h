//
//  CountryDescription.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/20/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryDescription : NSObject
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *country;
- (instancetype)initWithLength: (NSInteger) length andCode: (NSInteger) code andCountry: (NSString*) country;
@end

NS_ASSUME_NONNULL_END
