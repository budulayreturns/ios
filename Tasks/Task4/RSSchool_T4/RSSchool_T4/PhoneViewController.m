//
//  PhoneViewController.m
//  RSSchool_T4
//
//  Created by Дмитрий on 4/18/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController () 
@property (nonatomic, retain) CountryTemplates *templates;
@property (nonatomic, retain) CountryCodes *countries;
@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPhoneTextField];
    [self createTapGestureToHideKeyBoard];
    self.templates = [[CountryTemplates alloc] init];
    self.countries = [[CountryCodes alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    UITextField *textFiled = (UITextField*)[self.view viewWithTag:1];
    if (textFiled) {
        [textFiled addTarget:self action:@selector(phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void) viewDidDisappear:(BOOL)animated{
    UITextField *textFiled = (UITextField*)[self.view viewWithTag:1];
    if (textFiled) {
        [textFiled removeTarget:self action:@selector(phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void) createTapGestureToHideKeyBoard {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void) tapGesture {
    [self.view endEditing:YES];
}

- (void) createPhoneTextField {
    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 150, self.view.frame.size.width - 30, 44)];
    phoneTextField.tag = 1;
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.placeholder = @"Phone number";
    [phoneTextField addBorder];
    [phoneTextField setImageForLeftView:nil];
    phoneTextField.delegate = self;
    [self.view addSubview:phoneTextField];
    [phoneTextField release];
}

- (void) phoneTextFieldEditingChanged: (UITextField*) textField {
    [textField retain];
    NSString *number = [[textField.text getNumbersFromString] copy];
    
    CountryDescription *country = [[[self.countries searchCountryByString:number] retain] autorelease];
    if (country!=nil) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", country.country]];
        [textField setImageForLeftView:image];
        NSInteger codeLength = [[NSNumber numberWithInteger:country.code] stringValue].length;
        NSInteger numberlength = country.length + [[NSNumber numberWithInteger:country.code] stringValue].length;
        NSString *template = [[self.templates getTemplateByNumberLength:country.length] retain];
        textField.text = [self formatPhoneNumber:number andCodeLength:codeLength withFormat:template];
        [template release];
        if ([textField countNumbersInText] > numberlength){
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
    }
    else {
        //if ([textField.text containsNumericCharacters])
        textField.text = [textField.text getNumbersFromString];
        [textField setImageForLeftView:nil];
        
    }
    //plus
    NSLog(@"Editing: %lu", (unsigned long)number.length);
    [country release];
    [number release];
    [textField release];
}

//@"(xx) xxx-xxx",
//@"(xx) xxx-xx-xx",
//@"(xxx) xxx xx xx"

- (NSString *) formatPhoneNumber: (NSString*) number andCodeLength:(NSInteger) codeLength withFormat: (NSString*) format {
    [number retain];
    [format retain];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"x"];
    __block NSMutableString *formattedString = [[NSMutableString alloc] initWithString:format];
    __block NSInteger loc = 0;
    [format release];
    NSString *num = [[NSString alloc] initWithString:[number substringFromIndex:codeLength]];
    NSString *code = [[NSString alloc] initWithString:[number substringToIndex:codeLength]];
    [number release];
    
    if (num.length) {
        [num enumerateSubstringsInRange:NSMakeRange(0, num.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            NSRange range = [formattedString rangeOfCharacterFromSet:set options:0 range:NSMakeRange(0, formattedString.length)];
            if (range.location!=NSNotFound) {
                [formattedString replaceCharactersInRange:range withString:substring];
                loc = range.location;
            }
            else {
                *stop = YES;
            }
        }];
    }
    [num release];
    NSString *result = num.length ? [[[NSString stringWithFormat:@"+%@ %@", code, [formattedString substringWithRange:NSMakeRange(0, loc+1)]] copy] autorelease] : [[[NSString stringWithFormat:@"+%@",code] copy] autorelease];
    [formattedString release];
    [code release];
    return result;
}


//уборать формат если не совпала страна

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [textField retain];
    [string retain];
    BOOL valid = NO;
    if ([string isEqualToString:@""]){
        valid = YES;
    }
    else {
        if ([string containsNumericCharacters]) {
            valid = YES;
            if (range.location ==0) {
                textField.text = [textField.text removePlusPrefix];
                textField.text = [textField.text appendPlusPrefix];
            }
        }
        else {
            if (range.location ==0) {
                if ([string containsString: @"+"]&&![textField.text containsString:@"+"]) {
                    valid = YES;
                }
            }
        }
        if ([textField countNumbersInText] >= 12) {
            valid = NO;
        }
    }
    [string release];
    [textField release];
    return valid;
}


- (void) dealloc {
    [_countries release];
    [_templates release];
    [super dealloc];
}

@end

//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    [textField retain];
//    [string retain];
//    BOOL valid = NO;
//    if ([string isEqualToString:@""]){
//        valid = YES;
//    }
//    else {
//        if ([string containsNumericCharacters]) {
//            valid = YES;
//            if (range.location ==0) {
//                [textField removePlusFromText];
//                [textField appendPlusToText];
//            }
//        }
//        else {
//            if (range.location ==0) {
//                if ([string containsString: @"+"]&&![textField.text containsString:@"+"]) {
//                    valid = YES;
//                }
//            }
//        }
//        if ([textField countNumbersInText] >= 12) {
//            valid = NO;
//        }
//    }
//    [string release];
//    [textField release];
//    return valid;
//}
