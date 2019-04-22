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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _templates = [[CountryTemplates alloc] init];
        _countries = [[CountryCodes alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPhoneTextField];
    [self createTapGestureToHideKeyBoard];
}

- (void)viewWillAppear:(BOOL)animated {
    UITextField *textFiled = (UITextField*)[self.view viewWithTag:1];
    if (textFiled) {
        [textFiled addTarget:self action:@selector(phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    [textFiled release];
}

- (void) viewDidDisappear:(BOOL)animated{
    UITextField *textFiled = (UITextField*)[self.view viewWithTag:1];
    if (textFiled) {
        [textFiled removeTarget:self action:@selector(phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    [textFiled release];
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
    PhoneTextField *phoneTextField = [[PhoneTextField alloc] initWithFrame:CGRectMake(15, 150, self.view.frame.size.width - 30, 44)];
    phoneTextField.tag = 1;
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.placeholder = @"Phone number";
    [phoneTextField rs_addBorder];
    [phoneTextField rs_setImageForLeftView:nil];
    phoneTextField.delegate = self;
    [self.view addSubview:phoneTextField];
    [phoneTextField release];
}

- (void) phoneTextFieldEditingChanged: (UITextField*) textField {
    [textField retain];
    
//    UITextRange *textRange = [textField.selectedTextRange copy];
//    NSInteger offset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textRange.start];
//    NSLog(@"Offset new: %ld", (long)offset);
//    NSLog(@"Text: %@", textField.text);
    
    NSString *number = [[textField.text rs_getNumbersFromString] copy];
    CountryDescription *country = [[[self.countries searchCountryByString:number] retain] autorelease];
    if (country!=nil) {
        if ([textField isMemberOfClass:PhoneTextField.class]) {
            NSInteger numberlength = country.length + [[NSNumber numberWithInteger:country.code] stringValue].length;
            ((PhoneTextField*)textField).limitOfNumbers = numberlength;
        }
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", country.country]];
        [textField rs_setImageForLeftView:image];
        NSInteger codeLength = [[NSNumber numberWithInteger:country.code] stringValue].length;
        NSString *template = [[self.templates getTemplateByNumberLength:country.length] retain];
        textField.text = [NSString rs_formatPhoneNumber:number withFormat:template andCodeLength:codeLength];
        [template release];
    }
    else {
        if ([textField isMemberOfClass:PhoneTextField.class]) {
            ((PhoneTextField*)textField).limitOfNumbers = 12;
        }
        if ([textField.text rs_containsSpecialCharacters]) {
            textField.text = [textField.text rs_getNumbersFromString];
        }
        [textField rs_setImageForLeftView:nil];
    }
    
    if (![textField.text hasPrefix:@"+"]&&[textField.text rs_containsNumericCharacters]) {
        textField.text = [textField.text rs_appendPlusPrefix];
       //newPosition = [textField positionFromPosition:textRange.start offset:1];
    }
    //offset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textRange.start];
    
//    else {
//        //newPosition= [textField positionFromPosition:textRange.start offset:0];
//    }
//    newPosition= [textField positionFromPosition:textRange.start offset:0];
//    textField.selectedTextRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
//UITextPosition *newPosition = [textField.beginningOfDocument copy];
    
    
    NSLog(@"Editing: %lu", (unsigned long)number.length);
    [country release];
    [number release];
    [textField release];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [textField retain];
    [string retain];
    BOOL valid = NO;
    if ([string isEqualToString:@""]){
        valid = YES;
    }
    else {
        if ([string rs_containsNumericCharacters]) {
            valid = YES;
        }
        else {
            if (range.location ==0) {
                if ([string containsString: @"+"]&&![textField.text containsString:@"+"]) {
                    valid = YES;
                }
            }
        }
        if ([textField isMemberOfClass:PhoneTextField.class]) {
            if ([textField.text rs_containsNumericCharacters] >= ((PhoneTextField*)textField).limitOfNumbers) {
                valid = NO;
            }
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
//- (NSString *) formatPhoneNumber: (NSString*) number withFormat: (NSString*) format andCodeLength:(NSInteger) codeLength  {
//    [number retain];
//    [format retain];
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"x"];
//    __block NSMutableString *formattedString = [[NSMutableString alloc] initWithString:format];
//    __block NSInteger loc = 0;
//    [format release];
//    NSString *num = [[NSString alloc] initWithString:[number substringFromIndex:codeLength]];
//    NSString *code = [[NSString alloc] initWithString:[number substringToIndex:codeLength]];
//    [number release];
//
//    if (num.length) {
//        [num enumerateSubstringsInRange:NSMakeRange(0, num.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//            NSRange range = [formattedString rangeOfCharacterFromSet:set options:0 range:NSMakeRange(0, formattedString.length)];
//            if (range.location!=NSNotFound) {
//                [formattedString replaceCharactersInRange:range withString:substring];
//                loc = range.location;
//            }
//            else {
//                *stop = YES;
//            }
//        }];
//    }
//    [num release];
//    NSString *result = num.length ? [[[NSString stringWithFormat:@"+%@ %@", code, [formattedString substringWithRange:NSMakeRange(0, loc+1)]] copy] autorelease] : [[[NSString stringWithFormat:@"+%@",code] copy] autorelease];
//    [formattedString release];
//    [code release];
//    return result;
//}



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
