//
//  UITextField+RSSchool_T4_Extension.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/18/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "UITextField+RSSchool_T4_Extension.h"

@implementation UITextField (RSSchool_T4_Extension)


- (void) setText: (NSString*) text withFormat: (NSString*) format {
    [format retain];
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"" options:0 error:nil];
    //[format ap];
    
    
    //self.text;
    [format release];
   
}


- (void) addBorder {
    self.layer.cornerRadius = 6.f;
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 1.f;
}

- (void) setImageForLeftView: (nullable UIImage*) image {
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

- (NSInteger) countNumbersInText {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"[0-9]{1}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
    [regex release];
    return numberOfMatches;
}

- (void) appendPlusToText {
    NSString *plus = [[NSString alloc]initWithString:@"+"];
 
    if (![self.text containsString:plus]) {
        self.text = [plus stringByAppendingString:self.text];
//        UITextRange *range = [self.selectedTextRange copy];
//        UITextPosition *pos = self.beginningOfDocument;
//        [self insertText: plus];
//        self.selectedTextRange = range;
//        NSLog(@"Start %@", range.start);
//        [range release];
    }
    [plus release];
}

- (void) removePlusFromText {
    NSString *plus = [[NSString alloc]initWithString:@"+"];
    if ([self.text containsString:plus]) {
        self.text = [self.text stringByReplacingOccurrencesOfString:plus withString:@""];
    }
    [plus release];
}
@end
