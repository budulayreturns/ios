//
//  CountryTemplates.h
//  RSSchool_T4
//
//  Created by Дмитрий on 4/20/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryTemplates : NSObject
@property (nonatomic, retain, readonly) NSDictionary *templates;
- (nullable NSString*) getTemplateByNumberLength: (NSInteger) length;
@end

NS_ASSUME_NONNULL_END
